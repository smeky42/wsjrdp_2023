# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


module UnitKeyHelper
  extend ActiveSupport::Concern

  included do

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def getRandomKeys(person)
      plants = plants_yaml
      id = person.id
      ["#{id}-#{plants[rand(1...50)]}",
       "#{id}-#{plants[rand(51...100)]}",
       "#{id}-#{plants[rand(101...150)]}",
       "#{id}-#{plants[rand(151...200)]}",
       "#{id}-#{plants[rand(201...250)]}",
       "#{id}-#{plants[rand(251...300)]}",
       "#{id}-#{plants[rand(301...350)]}",
       "#{id}-#{plants[rand(351...400)]}",
       "#{id}-#{plants[rand(401...450)]}"]
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def plants_yaml
      YAML.load_file(Rails.root.join('../hitobito_wsjrdp_2023/config/plants.yml')) # [Rails.env]
    end

    def find_participant_by_key(key)
      key_persons = Person.where(role_wish: 'Teilnehmende*r').where(unit_keys: key)
      unless key_persons.empty?
        check_key_persons(key_persons)
        key_person = key_persons[0]
        return "#{key_person.id} - #{key_person.first_name} #{key_person.last_name}"
      end
      key
    end

    def find_unit_leader(person)
      key_persons = Person.where(role_wish: 'Unit Leitung').where('unit_keys like ?',
                                                                  "%#{person.unit_keys}%")

      unless key_persons.empty?
        key_person = key_persons[0]
        return "#{key_person.id} - #{key_person.first_name} #{key_person.last_name}"
      end
      "Mit dem Tag '#{person.unit_keys}' konnte kein*e Unitleiter*in zugeordnet werden."
    end

    def participant_list(person)
      keys = ''
      unless person.unit_keys.nil?
        JSON.parse(person.unit_keys).each do |key|
          keys += "\n #{find_participant_by_key(key)} "
        end
      end
      keys
    end

    def check_key_persons(key_persons)
      if key_persons.count > 1
        flash[:alert] = "Der Key #{key} wird von mehreren Personen genutzt \n"
        key_persons.each do |key_person|
          flash[:alert] += "#{key_person.id} - #{key_person.first_name} #{key_person.last_name}\n"
        end
        flash[:alert] += 'bitte wende dich an die Unit-Betreuung.'
      end
    end

  end
end
