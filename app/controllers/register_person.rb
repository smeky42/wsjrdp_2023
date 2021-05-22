# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

require Rails.root.join('db', 'seeds', 'support', 'person_seeder')

class RegisterPerson < PersonSeeder

  def seed_person(mail, first_name, last_name, role_wish)
    Rails.logger.debug('== Initially Seed Person: ' + mail + ' ' + first_name + ' ' + last_name \
                      + ' ' + role_wish.to_s)

    attrs = { email: mail, first_name: first_name, last_name: last_name }

    Person.seed_once(:email, attrs)
    person = Person.find_by(email: attrs[:email])

    seed_role(person, role_wish)

    person
  end

  private

  def seed_role(person, role_wish)
    role = get_role(role_wish)
    group = get_group(role_wish)

    role_attrs = { person_id: person.id, group_id: group.id, type: role.sti_name }
    Role.seed_once(*role_attrs.keys, role_attrs)
  end

  def get_role(role_wish)
    case role_wish
    when 'Unit Leitung'
      Group::Unit::UnassignedLeader
    when 'Kontingentsteam'
      Group::Root::Unassigned
    end
  end

  def get_group(role_wish)
    case role_wish
    when 'Unit Leitung'
      Group.find_by(name: 'Ohne Unit')
    when 'Kontingentsteam'
      Group.find_by(name: 'Kontingent')
    end
  end
end
