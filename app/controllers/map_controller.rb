# encoding: utf-8
# frozen_string_literal: true

require 'rest-client'

class MapController < ApplicationController
  layout 'application'

  skip_authorization_check
  def index
    # TODO: CanCan
    @access = current_user.role?('Group::Root::Admin') ||
              current_user.role?('Group::Root::Leader') ||
              current_user.role?('Group::UnitSupport::Leader') ||
              current_user.role?('Group::UnitSupport::Member')

    unless @access
      flash[:alert] = I18n.t('activerecord.alert.map_access')
      return
    end

    collect_user
  end

  def collect_user
    people = Person.where('primary_group_id=3')

    @users = []
    @invalid_users = []
    people.each do |person|
      add_user(person)
    end
  end

  def add_user(person)
    id = person.id
    name = person.full_name
    link = get_link(person)
    role = 'Unitleitung'

    person = update_geodata(person)

    if !person.latitude.nil? && !person.longitude.nil?
      @users.push([id, name, person.latitude, person.longitude, role, link])
    else
      @invalid_users.push([id, name, link])
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

  def get_link(person)
    '<a href="https://anmeldung.worldscoutjamboree.de/groups/' + person.primary_group_id.to_s +
      '/people/' + person.id.to_s + '/management/edit">' + person.full_name.to_s + '</a>'
  end
end
