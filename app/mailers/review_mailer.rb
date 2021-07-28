# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


class ReviewMailer < JamboreeMailer
  def review_mail(person)
    Rails.logger.debug("== Send Review Mail to #{person.email}")
    @mail = person.email
    @url = 'https://worldscoutjamboree.de/anmeldung'
    @resource = person
    mail(to: person.email, subject:   'Deine Anmeldung'\
                                      ' zum World Scout Jamboree 2023 wurde überprüft')
  end

  def upload_mail(person)
    Rails.logger.debug("== Send Upload Mail to #{person.email}")
    @mail = person.email
    @url = 'https://worldscoutjamboree.de/anmeldung'
    @resource = person
    mail(to: person.email, subject:   'Du hast deine Anmeldung'\
                                      ' zum World Scout Jamboree 2023 vollständig eingereicht')
  end
end
