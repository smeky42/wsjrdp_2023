# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class Person::CheckController < ApplicationController
  include UnitKeyHelper

  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @person ||= group.people.find(params[:id])
    @manage = manage

    # flash[:alert] = params[:url]

    status_button
    save_put
  end

  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def manage
    current_user.role?('Group::Root::Admin') ||
    current_user.role?('Group::Root::Leader') ||
    current_user.role?('Group::UnitSupport::Leader') ||
    current_user.role?('Group::UnitSupport::Member') ||
    current_user.role?('Group::Ist::Leader')
  end

  def authorize_action
    authorize!(:edit, entry)
  end

  def status_button
    if @manage && request.get?
      cmt_check
      cmt_documents
      @person.save
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/AbcSize
  def save_put
    if @manage && request.put?
      @person.status = params['person']['status'] unless params['person']['status'].nil?

      @person.role_wish = params['person']['role_wish'] unless params['person']['role_wish'].nil?
      @person.first_name = params['person']['first_name'] unless params['person']['first_name'].nil?
      @person.last_name = params['person']['last_name'] unless params['person']['last_name'].nil?
      @person.birthday = params['person']['birthday'] unless params['person']['birthday'].nil?
      @person.gender = params['person']['gender'] unless params['person']['gender'].nil?

      @person.sepa_name = params['person']['sepa_name'] unless params['person']['sepa_name'].nil?
      @person.sepa_address = params['person']['sepa_address'] unless params['person']['sepa_address'].nil?
      @person.sepa_mail = params['person']['sepa_mail'] unless params['person']['sepa_mail'].nil?
      @person.sepa_iban = params['person']['sepa_iban'] unless params['person']['sepa_iban'].nil?
      @person.sepa_bic = params['person']['sepa_bic'] unless params['person']['sepa_bic'].nil?

      @person.save
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/AbcSize


  def send_review_mail(person)
    ReviewMailer.review_mail(person).deliver_now
    flash[:notice] =
      "Eine Mail zur Überprüfung der Anmeldung wurde an #{person.email} versandt!"
  end

  def cmt_check
    if params[:url] == 'cmt_review'
      @person.status = 'in Überprüfung durch KT'
    end
  end

  def cmt_documents
    if params[:url] == 'cmt_documents'
      send_review_mail(@person)
      @person.status = 'Dokumente vollständig überprüft'
      if @person.role_wish == 'Unit Leitung' && @person.unit_keys.empty?
        keys = getRandomKeys(@person).to_s
        @person.unit_keys = keys
      end
    end
  end

end
