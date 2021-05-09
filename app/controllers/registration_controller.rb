# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class RegistrationController < ActionController::Base
  layout 'application'
  helper_method :current_user, :origin_user

  def index
    @possible_roles = Settings.person.roles
    if request.post? && check_mail && check_name
      register_person
    end
  end

  private

  def current_user
    nil
  end

  def origin_user
    nil
  end

  def check_name
    if params[:first_name].length < 2 || params[:last_name].length < 2
      flash[:alert] = 'Bitte gib deinen vollständigen Vor- und Nachnamen ein.'
      false
    end
  end

  def check_mail
    if !Truemail.valid?(params[:mail])
      flash[:alert] = 'Bitte gib deine korrekte Mailadresse ein.'
      return false
    elsif Person.find_by(email: params[:mail])
      flash[:alert] = 'Es existiert schon ein Account mit dieser e-Mail Adresse.'\
      ' Du kannst dein Passwort über "Passwort vergessen?" zurücksetzen.'
      return false
    end
    true
  end

  def register_person
    register_person = RegisterPerson.new
    person = register_person.seed_person(params[:mail],
                                          params[:first_name],
                                          params[:last_name],
                                          params[:role])
    person
  end

end
