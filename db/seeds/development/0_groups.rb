# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


require Rails.root.join('db', 'seeds', 'support', 'group_seeder')

seeder = GroupSeeder.new

root = Group.roots.first
srand(42)

if root.address.blank?
  root.update_attributes(seeder.group_attributes)
  root.default_children.each do |child_class|
    child_class.first.update_attributes(seeder.group_attributes)
  end
end

Group::UnitSupport.seed(:name, :parent_id,
  {
    name: 'Unit Betreuung',
    address: "Chausseestraße 128/129",
    zip_code: "10115",
    town: "Berlin",
    country: "DE",
    email: "unit-info@wsjrdp.de",
    parent_id: root.id
  }
)

Group::Ist.seed(:name, :parent_id,
  {
    name: 'IST',
    address: "Chausseestraße 128/129",
    zip_code: "10115",
    town: "Berlin",
    country: "DE",
    email: "ist-info@wsjrdp.de",
    parent_id: root.id
  }
)

unit_support = Group.find_by_name('Unit Betreuung')
Group::Unit.seed(:name, :parent_id,
  {
    name: 'Unit Unassigned',
    address: "Nirgendwo 42",
    zip_code: "1234",
    town: "Niemandsland",
    country: "DE",
    email: "unitnunassigned@wsjrdp.de",
    parent_id: unit_support.id
  },
  {
    name: 'Unit NBG',
    address: "Äußere Bayreuther Straße 1234",
    zip_code: "90411",
    town: "Nürnberg",
    country: "DE",
    email: "unitnbg@wsjrdp.de",
    parent_id: unit_support.id
  },
  {
    name: 'Unit HH',
    address: "Reeperbahn 63",
    zip_code: "20359",
    town: "Hamburg",
    country: "DE",
    email: "unitnbg@wsjrdp.de",
    parent_id: unit_support.id
  }
)

Group.rebuild!
