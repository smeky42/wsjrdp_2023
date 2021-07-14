# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

# rubocop:disable Rails/ApplicationController
class RegistrationController < ActionController::Base
  layout 'application'
  helper_method :current_user, :origin_user

  def index
    @possible_roles = Settings.person.roles

    if request.post?
      if check_mail && check_name && check_birthday
        person = register_person
        send_registration_mail(person)
      end
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
      return false
    end
    true
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

  def check_birthday
    unless params[:birthday].match(/\d\d\.\d\d\.\d\d\d\d/)
      flash[:alert] = 'Bitte gib deinen Geburstag im Format dd.mm.yyyy ein.'
      return false
    end

    check_age
  end

  def check_age
    birthday = params[:birthday].to_date
    if params[:role] == 'Kontingentsteam' || params[:role] == 'Unit Leitung'
      if to_old(birthday) || to_young(birthday)
        return false
      end

      return true
    end
    flash[:alert] = 'Deine Wunschrolle gibt es nicht.'
    false
  end

  def to_old(birthday)
    if birthday < Date.new(1920, 1, 1)
      flash[:alert] = 'Bitte gib deinen richtigen Geburtstag an.'
      return true
    end
    false
  end

  def to_young(birthday)
    if birthday > Date.new(2004, 4, 1)
      flash[:alert] = 'Als ' + params[:role] + ' musst du mindestens 18 Jahre alt sein.'
      return true
    end
    false
  end

  def register_person
    register_person = RegisterPerson.new
    person = register_person.seed_person(params[:mail],
                                         params[:first_name],
                                         params[:last_name],
                                         params[:role],
                                         params[:birthday])
    person
  end

  def send_registration_mail(person)
    WelcomeMailer.welcome_email(person).deliver_now
    flash[:notice] = 'Eine Mail mit deinen Login Daten wurde an ' + params[:mail] + ' versandt!'
  end

end
# rubocop:enable Rails/ApplicationController
