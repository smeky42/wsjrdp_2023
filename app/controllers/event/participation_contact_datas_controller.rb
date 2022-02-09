# encoding: utf-8
# frozen_string_literal: true

class Event::ParticipationContactDatasController < ApplicationController

  helper_method :group, :event, :entry

  authorize_resource :entry, class: Event::ParticipationContactData

  decorates :group, :event

  before_action :set_entry, :group

  def edit
      if @group.id != current_user.primary_group_id 
        flash[:alert] ||= "Du gehörst zur Gruppe #{Group.find(current_user.primary_group_id).name}, " +
        "dies ist eine Anmeldung für eine Veranstaltung der Gruppe #{@group.name}. " +
        "Bist du sicher, dass du dich zu dieser Veranstaltung anmelden möchtest?"  
      end 
  end

  def update
    if entry.save
      redirect_to new_group_event_participation_path(
        group,
        event,
        event_role: { type: params[:event_role][:type] }
      )
    else
      render :edit
    end
  end

  private

  def entry
    @participation_contact_data
  end

  def build_entry
    Event::ParticipationContactData.new(event, current_user)
  end

  def set_entry
    @participation_contact_data =
      if params[:event_participation_contact_data]
        Event::ParticipationContactData.new(event, current_user, model_params)
      else
        build_entry
      end
  end

  def event
    @event ||= Event.find(params[:event_id])
  end

  def group
    @group ||= Group.find(params[:group_id])
  end

  def model_params
    params.require('event_participation_contact_data').permit(permitted_attrs)
  end

  def permitted_attrs
    PeopleController.permitted_attrs
  end

end
