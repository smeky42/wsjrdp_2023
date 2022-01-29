# encoding: utf-8
# frozen_string_literal: true

require 'rest-client'

class Group::MapController < ApplicationController
  # layout 'application'
  before_action :authorize_action
  decorates :group, :person

  include UnitKeyHelper

  def index
    @group ||= Group.find(params[:group_id])
    @members ||= Person.where(primary_group_id: params[:group_id])

    @users = []
    @members.each do |person|
      add_user(person)
    end
  end


  def add_user(person)
    id = person.id
    name = person.full_name
    link = get_link(person)
    role = person.role_wish
    status = person.status
    person = update_geodata(person)
    unit_color = get_unit_color(person)
    unit_leader_id = find_unit_leader_id(person)

    if !person.latitude.nil? && !person.longitude.nil?
      @users.push([id, name, person.latitude, person.longitude, role, link, status, unit_color,
                   unit_leader_id])
    end 
  end

  def update_geodata(person)
    if person.address.present? && (person.zip_code.present? || person.town.present?)
      address = person.address + ' ' + person.zip_code + ' ' + person.town

      unless person.latitude.present? && person.longitude.present?
        person = get_geodata(person, address)
      end
    end
    person
  end

  def get_geodata(person, address)
    address = I18n.transliterate(address.gsub(' ', '+'))
    rest_response = geodata_response(address)

    if rest_response['status'] == 'OK'
      person.latitude = rest_response['results'][0]['geometry']['location']['lat'].to_s
      person.longitude = rest_response['results'][0]['geometry']['location']['lng'].to_s
      person.save
    end
    person
  end

  def geodata_response(address)
    ActiveSupport::JSON.decode(
      RestClient.get('https://maps.googleapis.com/maps/api/geocode/json?address=' +
        address + '&key=AIzaSyAPS-uHgTIug9RlK_wBotqn_hrMTkQeUVM')
    )
  end

  def get_unit_color(person)
    if person.unit_color.blank? || person.unit_color.length != 6
      return ''
    end

    person.unit_color
  end

  def get_link(person)
    '<a href="' + request.base_url + '/groups/' + person.primary_group_id.to_s +
      '/people/' + person.id.to_s + '" target="_blank">' + person.full_name.to_s + '</a>'
  end

  def entry
    @group ||= Group.find(params[:group_id])
  end

  def authorize_action
    authorize!(:edit, entry)
  end
end
