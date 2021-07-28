# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class Person::UploadController < ApplicationController
  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @person ||= group.people.find(params[:id])
    if request.put?
      upload_files
    end

    check_status
  end

  def show_registration
    download_file(@person.upload_registration_pdf)
  end

  def show_registration_generated
    download_file(@person.generated_registration_pdf)
  end

  def show_sepa
    download_file(@person.upload_sepa_pdf)
  end

  def show_passport
    download_file(@person.upload_passport_pdf)
  end

  def show_recommondation
    download_file(@person.upload_recommondation_pdf)
  end

  def show_good_conduct
    download_file(@person.upload_sepa_pdf)
  end

  def show_data_processing
    download_file(@person.upload_data_processing_pdf)
  end


  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def authorize_action
    authorize!(:edit, entry)
  end

  def download_file(file)
    if file.present? && can?(:edit, @person)
      file_name = File.basename(file)
      File.open(file, 'r') do |f|
        send_data f.read.force_encoding('BINARY'), filename: file_name,
                                                   type: 'application/pdf',
                                                   disposition: 'attachment'
      end
    end
  end

  # rubocop:disable Metrics/AbcSize
  def upload_files
    upload_file(params[:person][:upload_passport_pdf], 'upload_passport_pdf')
    upload_file(params[:person][:upload_registration_pdf], 'upload_registration_pdf')
    upload_file(params[:person][:upload_sepa_pdf], 'upload_sepa_pdf')
    upload_file(params[:person][:upload_recommondation_pdf], 'upload_recommondation_pdf')
    upload_file(params[:person][:upload_good_conduct_pdf], 'upload_good_conduct_pdf')
    upload_file(params[:person][:upload_data_processing_pdf], 'upload_data_processing_pdf')
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/MethodLength
  def upload_file(file_param, file_name)
    if file_param.nil?
      return
    end

    if file_param.content_type == 'application/pdf'
      file_path = file_path(file_name)
      FileUtils.mkdir_p(File.dirname(file_path)) unless File.directory?(File.dirname(file_path))

      File.open(file_path, 'wb') do |file|
        file.write(file_param.read)
      end

      @person[file_name] = file_path
      @person.save

    else
      flash[:alert] = 'Du kannst nur PDF Files hochladen.'
    end
  end
  # rubocop:enable Metrics/MethodLength


  def file_path(file_name)
    date = Time.zone.now.strftime('%Y-%m-%d-%H-%M-%S')
    file_name = file_name.remove('upload_').remove('_pdf')
    "#{generate_file_path}#{date}--#{@person.id}-#{file_name}.pdf"
  end

  def generate_file_path
    "#{Rails.root}/private/uploads/person/pdf/#{@person.id}/"
  end

  def check_status
    if unit_leader_complete ||
      cmt_complete ||
      ist_complete ||
      participant_complete

      upload_complete
    end
  end

  def upload_complete
    if @person.status == 'gedruckt'
      @person.status = 'Upload vollständig'
      send_upload_mail(@person)
      @person.save
    end
  end

  def standard_documents_complete
    @person.upload_passport_pdf.present? &&
    @person.upload_registration_pdf.present? &&
    @person.upload_sepa_pdf.present?
  end

  def participant_complete
    @person.role_wish == 'Teilnehmer*in' &&
    standard_documents_complete &&
    @person.status == 'gedruckt'
  end

  def unit_leader_complete
    @person.role_wish == 'Unit Leitung' &&
    standard_documents_complete
    @person.upload_recommondation_pdf.present? &&
    @person.upload_good_conduct_pdf.present? &&
    @person.upload_data_processing_pdf.present? &&
    @person.status == 'gedruckt'
  end

  def cmt_complete
    @person.role_wish == 'Kontingentsteam' &&
    standard_documents_complete &&
    @person.upload_good_conduct_pdf.present? &&
    @person.upload_data_processing_pdf.present? &&
    @person.status == 'gedruckt'
  end

  def ist_complete
    @person.role_wish == 'IST' &&
    standard_documents_complete &&
    @person.upload_good_conduct_pdf.present? &&
    @person.status == 'gedruckt'
  end

  def send_upload_mail(person)
    ReviewMailer.upload_mail(person).deliver_now
    flash[:notice] =
      "Eine Mail zur Bestätigung der Vollständigen Anmeldung wurde an #{params[:mail]} versandt!"
  end

end
