# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class Group::PrintRegistrationController < ApplicationController
  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @members ||= Person.where(primary_group_id: params[:group_id])

    @printable = printable

    unless printable
      flash[:alert] = not_printable_reason
    else 
      pdf = Wsjrdp2023::Export::Pdf::GroupRegistration.new_pdf(@group, @members)

      folder = file_folder
      name = file_name
      full_name = folder + name
      FileUtils.mkdir_p(folder) unless File.directory?(folder)

      pdf.render_file full_name

      send_data File.read(full_name), type: :pdf, disposition: 'attachment', filename: name
    end
     
  end

  def not_printable_reason
    reason = 'Gruppe nicht vollständig'
    reason
  end

  def printable
    not_printable_reason.empty?
    true 
  end

  private

  def entry
    @group ||= Group.find(params[:group_id])
  end

  def authorize_action
    authorize!(:edit, entry)
  end
 
  def file_name
    date = Time.zone.now.strftime('%Y-%m-%d-%H-%M-%S')
    "#{date}--#{@group.id}-group-registration-generated.pdf"
  end

  def file_folder
    "#{Rails.root}/private/uploads/group/pdf/#{@group.id}/"
  end

end
