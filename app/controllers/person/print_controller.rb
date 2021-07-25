# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class Person::PrintController < ApplicationController
  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @person ||= group.people.find(params[:id])
    @printable = printable
    unless printable
      flash[:alert] = (I18n.t 'activerecord.alert.print') + ': ' + not_printable_reason
    end

    unless @person.status == 'registriert'
      flash[:info] = (I18n.t 'activerecord.text.print')
    end
  end

  def preview
    if printable && (@person.status == 'registriert')
      pdf = Wsjrdp2023::Export::Pdf::Registration.render(@person, true)

      send_data pdf, type: :pdf, disposition: 'inline', filename: 'Anmeldung-WSJ-Vorschau.pdf'
    end
  end

  def submit
    if printable && (@person.status == 'registriert')
      pdf = Wsjrdp2023::Export::Pdf::Registration.new_pdf(@person, false)

      folder = file_folder
      name = file_name
      full_name = folder + name
      FileUtils.mkdir_p(folder) unless File.directory?(folder)

      pdf.render_file full_name

      @person.status = 'gedruckt'
      @person.upload_registration_pdf = full_name
      @person.save

      send_data File.read(full_name), type: :pdf, disposition: 'inline', filename: name
    end
  end

  def not_printable_reason
    reason = ''
    @person.first_name.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.first_name')
    @person.last_name.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.last_name')
    @person.email.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.email')
    @person.address.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.address')
    @person.zip_code.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.zip_code')
    @person.town.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.town')
    @person.country.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.country')
    @person.gender.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.gender')
    @person.birthday.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.birthday')
    @person.rdp_association_number.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.rdp_association_number')
    if @person.years.to_i < 18
      @person.additional_contact_name_a.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.additional_contact_name_a')
      unless @person.additional_contact_single
        @person.additional_contact_name_b.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.additional_contact_name_b')
      end
    end
    @person.sepa_name.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.sepa_name')
    @person.sepa_address.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.sepa_address')
    @person.sepa_mail.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.sepa_mail')
    @person.sepa_iban.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.sepa_iban')
    @person.role_wish.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.role_wish')
    @person.shirt_size.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.shirt_size')
    @person.uniform_size.present? ? '' : reason += "\n - " + (I18n.t 'activerecord.attributes.person.uniform_size')

    reason += to_old(@person.birthday, @person.role_wish)
    reason += to_young(@person.birthday, @person.role_wish)

    IBANTools::IBAN.valid?(@person.sepa_iban) ? '' : reason += "\n - " + (I18n.t 'activerecord.alert.iban')
    Truemail.valid?(@person.sepa_mail) ? '' : reason += "\n - " + (I18n.t 'activerecord.alert.sepa_mail')


    reason
  end

  def printable
    not_printable_reason.empty?
  end

  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def authorize_action
    authorize!(:edit, entry)
  end

  # TODO: Duplicated Code in Print Controller
  def to_old(birthday, role)
    if (role == 'Teilnehmende*r') && (birthday < Date.new(2005, 7, 22))
      return "\n - Du bist leider zu alt für die Teilnahme als #{role} "
    elsif birthday < Date.new(1920, 1, 1)
      return "\n - Bitte gib deinen richtigen Geburtstag an."
    end

    ''
  end

  def to_young(birthday, role)
    if (role == 'Teilnehmende*r') && (birthday > Date.new(2009, 7, 31))
      return "\n - Du bist leider zu jung für die Teilname am Jamboree."
    elsif (role == 'Unit Leitung') && birthday > Date.new(2004, 4, 1)
      return "\n - Als #{role} musst du mindestens 18 Jahre alt sein."
    elsif (role == 'IST') && birthday >= Date.new(2005, 7, 22)
      return "\n - Als #{role} musst du am Jamboree mindestens 18 Jahre alt sein."
    elsif (role == 'Kontingentsteam') && @person.years.to_i < 18
      return "\n - Für das #{role} musst du mindestens 18 Jahre alt sein."
    end

    ''
  end

  def file_name
    date = Time.zone.now.strftime('%Y-%m-%d-%H-%M-%S')
    "#{date}--#{@person.id}-registration-generated.pdf"
  end

  def file_folder
    "#{Rails.root}/private/uploads/person/pdf/#{@person.id}/"
  end

end
