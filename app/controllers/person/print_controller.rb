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
      flash[:alert] = (I18n.t 'errors.print') + ': ' + not_printable_reason
    end
  end

  def preview
    if printable
      pdf = Wsjrdp2023::Export::Pdf::Registration.render(@person, true)

      send_data pdf, type: :pdf, disposition: 'inline', filename: 'Anmeldung-WSJ-Vorschau.pdf'
    end
  end

  def submit
    if printable
      pdf = Wsjrdp2023::Export::Pdf::Registration.render(@person, false)

      send_data pdf, type: :pdf, disposition: 'inline', filename: person.id.to_s +
       '-Anmeldung-WSJ-' + Time.zone.today.to_s + '.pdf'
    end
  end

  def not_printable_reason
    reason = ''
    @person.first_name.present? ? '' : reason += "\n - " \
     + (I18n.t 'activerecord.attributes.person.first_name')
    @person.last_name.present? ? '' : reason += "\n - "\
     + (I18n.t 'activerecord.attributes.person.last_name')
    @person.birthday.present? ? '' : reason += "\n - "\
     + (I18n.t 'activerecord.attributes.person.birthday')
    @person.email.present? ? '' : reason += "\n - "\
     + (I18n.t 'activerecord.attributes.person.email')
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

end
