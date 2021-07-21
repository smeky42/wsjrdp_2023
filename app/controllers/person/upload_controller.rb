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
    flash[:alert] = "Upload #{Rails.root}"
    if request.put?
      flash[:notice] = 'Uploaded: '
      upload_files
    end
  end

  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def authorize_action
    authorize!(:edit, entry)
  end

  def upload_files
    upload_file(params[:person][:upload_passport_pdf], 'upload_passport_pdf')
    upload_file(params[:person][:upload_registration_pdf], 'upload_registration_pdf')
    upload_file(params[:person][:upload_sepa_pdf], 'upload_sepa_pdf')
    upload_file(params[:person][:upload_recommondation_pdf], 'upload_recommondation_pdf')
    upload_file(params[:person][:upload_good_conduct_pdf], 'upload_good_conduct_pdf')
  end

  def upload_file(file_param, file_name)
    if !file_param.nil? && (file_param.content_type == 'application/pdf')
      file_path = file_path(file_name)
      FileUtils.mkdir_p(File.dirname(file_path)) unless File.directory?(File.dirname(file_path))

      File.open(file_path, 'wb') do |file|
        file.write(file_param.read)
      end
      @person[file_name] = file_path
      @person.save

      flash[:notice] += "#{file_path}, "
    end
  end

  def file_path(file_name)
    date = Time.zone.now.strftime('%Y-%m-%d-%H-%M-%S')
    file_name = file_name.remove('upload_').remove('_pdf')
    "#{generate_file_path}#{date}--#{@person.id}-#{file_name}.pdf"
  end

  def generate_file_path
    "#{Rails.root}/private/uploads/person/pdf/#{@person.id}/"
  end

end
