# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


class WelcomeMailer < JamboreeMailer
  def welcome_email(person)
    Rails.logger.debug("== Send Mail Welcome Mail to #{person.email}")
    @mail = person.email
    @url = 'https://worldscoutjamboree.de/anmeldung'
    @resource = person
    @token = person.generate_reset_password_token!
    mail(to: person.email, subject:   'Willkommen bei der Anmeldung'\
                                      ' zum World Scout Jamboree 2023')
  end
end
