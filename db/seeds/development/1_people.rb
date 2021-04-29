# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


require Rails.root.join('db', 'seeds', 'support', 'person_seeder')

class Wsjrdp2023PersonSeeder < PersonSeeder

  def amount(role_type)
    case role_type.name.demodulize
    when 'Member' then 5
    else 1
    end
  end

end

seeder = Wsjrdp2023PersonSeeder.new

seeder.seed_all_roles

root = Group.root
seeder.seed_developer("Andi Admin", "andi.admin@wsjrdp.de", root, Group::Root::Admin)
