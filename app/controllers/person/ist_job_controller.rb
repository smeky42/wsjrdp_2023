# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class Person::IstJobController < ApplicationController
  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @person ||= group.people.find(params[:id])

    unless authorize_view
      return
    end

    @authorize_view = authorize_view
    @possible_ist_jobs = YAML.load_file(Rails.root.join('' \
                                    '../hitobito_wsjrdp_2023/config/ist_jobs.yml'))

    @job = IstJobs.where(subject_id: @person.id).order('created_at').last
    if @job.nil?
      @job = IstJobs.new
    end

    save_put
  end

  def authorize_view
    (current_user.role?('Group::Root::Admin') ||
    current_user.role?('Group::Root::Leader') ||
    current_user.role?('Group::Ist::Leader') ||
    current_user == @person)
  end

  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def authorize_action
    authorize!(:edit, entry)
  end

  # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  def save_put
    if request.put? && @authorize_view

      id = if IstJobs.last.nil?
             0
           else
             IstJobs.last.id + 1
           end
      IstJobs.create(id: id,
                     subject_id: @person.id,
                     author_id: current_user.id,
                     first_choice: params[:first_choice],
                     first_specialization: params[:first_specialization],
                     second_choice: params[:second_choice],
                     second_specialization: params[:second_specialization],
                     third_choice: params[:third_choice],
                     third_specialization: params[:third_specialization],
                     created_at: DateTime.now)
      flash[:notice] = 'IST Jobwunsch gespeichert'
      redirect_back(fallback_location: '/')
    end
  end
  # rubocop:enable ,Metrics/MethodLength,Metrics/AbcSize

end
