# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


class StatisticController < ApplicationController
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
      nil
    end

    @registered_persons_count = registered_person
  end

  def registered_person
    start_date = Date.parse('2021-07-30')
    end_date = Time.zone.today
    @total = {}
    @ist = {}
    @tn = {}
    @ul = {}

    (start_date..end_date).each do |day|
      @total[day] =
        Person.where(created_at: day.midnight..day.end_of_day).where.not(role_wish: 'NULL').count
      @ist[day] =
        Person.where(created_at: day.midnight..day.end_of_day, role_wish: 'IST').count
      @tn[day] =
        Person.where(created_at: day.midnight..day.end_of_day, role_wish: 'Teilnehmende*r').count
      @ul[day] =
        Person.where(created_at: day.midnight..day.end_of_day, role_wish: 'Unit Leitung').count
    end

    @person_array = [{ name: 'Gesamt', data: @total }, { name: 'Teilnehmer', data: @tn },
                     { name: 'IST', data: @ist }, { name: 'Unit-Leader', data: @ul }]
  end


end
