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
    @medicine = medicine
    @medicine_notes = medicine_notes
    @leader_of_unit = leader_of_unit
    @check_url_id = check_url_document_id(params[:url])
   
    status_button
    save_put
  end

  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def leader_of_unit
    current_user.role?('Group::Unit::Leader')
  end

  def manage
    current_user.role?('Group::Root::Admin') ||
    current_user.role?('Group::Root::Leader') ||
    current_user.role?('Group::UnitSupport::Leader') ||
    current_user.role?('Group::UnitSupport::Member') ||
    current_user.role?('Group::Ist::Leader')
  end

  def check_url_document_id(url_id) 
    if url_id.nil?
      return false 
    end 
    date = @person.upload_registration_pdf.split("/")[-1].split("-")
    day = date[2]
    month = date[1]
    year = date[0]
    doc_id = Base64.encode64(@person.id.to_s + "#{day}.#{month}.#{year}").gsub(/\n+/, "")

    if (url_id == doc_id)
      return true
    else  
      flash[:alert] = "Der QR Code passt nicht zur Anmeldung des Teilnehmers. " +  
      "Bitte überprüfe ob du die aktuellsten Anmeldeunterlagen hast.  " 
      if @manage
        flash[:alert] += " \n Id should be #{doc_id}"
      end 

    end
    false 
  end 

  def medicine
    current_user.id == 2 ||
    current_user.id == 320 ||
    current_user.id == 87
  end

  def authorize_action
    authorize!(:edit, entry)
  end

  def status_button
    if (@manage|| @leader_of_unit) && request.get?
      ul_check 
      @person.save 
    end 

    if @manage && request.get?
      cmt_check
      cmt_documents
      @person.save
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/AbcSize
  def save_put
    if @manage && request.put? && !params[:person].nil?
      @person.status = params['person']['status'] unless params['person']['status'].nil?

      @person.role_wish = params['person']['role_wish'] unless params['person']['role_wish'].nil?
      @person.first_name = params['person']['first_name'] unless params['person']['first_name'].nil?
      @person.last_name = params['person']['last_name'] unless params['person']['last_name'].nil?
      @person.birthday = params['person']['birthday'] unless params['person']['birthday'].nil?
      @person.gender = params['person']['gender'] unless params['person']['gender'].nil?
      @person.unit_color = params['person']['unit_color'] unless params['person']['unit_color'].nil?

      @person.sepa_name = params['person']['sepa_name'] unless params['person']['sepa_name'].nil?
      @person.sepa_address = params['person']['sepa_address'] unless params['person']['sepa_address'].nil?
      @person.sepa_mail = params['person']['sepa_mail'] unless params['person']['sepa_mail'].nil?
      @person.sepa_iban = params['person']['sepa_iban'] unless params['person']['sepa_iban'].nil?
      @person.sepa_bic = params['person']['sepa_bic'] unless params['person']['sepa_bic'].nil?

      @person.medicine_status = params['person']['medicine_status'] unless params['person']['medicine_status'].nil?

      @person.upload_passport_pdf = params['person']['upload_passport_pdf'] unless params['person']['upload_passport_pdf'].nil?
      @person.upload_registration_pdf = params['person']['upload_registration_pdf'] unless params['person']['upload_registration_pdf'].nil?
      @person.upload_sepa_pdf = params['person']['upload_sepa_pdf'] unless params['person']['upload_sepa_pdf'].nil?
      @person.upload_recommondation_pdf = params['person']['upload_recommondation_pdf'] unless params['person']['upload_recommondation_pdf'].nil?
      @person.upload_good_conduct_pdf =  params['person']['upload_good_conduct_pdf'] unless params['person']['upload_good_conduct_pdf'].nil?
      @person.upload_data_processing_pdf = params['person']['upload_data_processing_pdf'] unless params['person']['upload_data_processing_pdf'].nil?

      @person.save
    end

    if @medicine && @manage && request.put? && !params[:medicine_note].nil?
      MedicineNotes.create(id: MedicineNotes.count + 1,
                           subject_id: @person.id,
                           author_id: current_user.id,
                           text: params[:medicine_note],
                           created_at: DateTime.now,
                           updated_at: DateTime.now,
                           subject_type: 'Person')
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
      if @person.role_wish == 'Unit Leitung' && @person.unit_keys.nil?
        keys = getRandomKeys(@person).to_s
        @person.unit_keys = keys
      end
    end
  end

  def ul_check
    if params[:task] == 'l_review' && check_url_document_id(params[:url])
      @person.status = 'bestätigt durch Leitung'
      @person.save
    end
  end

  def medicine_notes
    MedicineNotes.where(subject_id: @person.id)
  end

end
