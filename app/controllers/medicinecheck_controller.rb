# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


class MedicinecheckController < ApplicationController
  layout 'application'

  skip_authorization_check
  def index
    # TODO: CanCan
    @access = current_user.role?('Group::Root::Admin') ||
              current_user.role?('Group::Root::Leader')

    unless @access
      flash[:alert] = I18n.t('activerecord.alert.map_access')
      nil
    end

    @person_to_check = Person.where(status: 'Dokumente vollständig überprüft',
                           medicine_status: 'ungeprüft').first
  end
end
