# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023::Person
  extend ActiveSupport::Concern

  include UnitKeyHelper

  included do
    # TODO: Requires change in person.rb hitobito
    # Person::GENDERS += ['d']

    Person::PUBLIC_ATTRS << :rdp_association << :rdp_association_region
    Person::PUBLIC_ATTRS << :rdp_association_sub_region << :rdp_association_group
    Person::PUBLIC_ATTRS << :rdp_association_number << :longitude << :latitude

    Person::FILTER_ATTRS << :status << :role_wish << :passport_germany << :passport_valid
    Person::FILTER_ATTRS << :rdp_association << :rdp_association_region
    Person::FILTER_ATTRS << :rdp_association_sub_region << :rdp_association_group
    Person::FILTER_ATTRS << :medicine_status
  end

  def role?(role)
    # TODO: use view.can
    unless roles.loaded?
      Person::PreloadGroups.for([self])
    end

    roles.each do |r|
      if r.type == role.to_s
        return true
      end
    end
    false
  end

  def mail_name
    clean_nickname = nickname.gsub(/\s+/, '')

    if clean_nickname.length < 3
      return first_name
    end

    clean_nickname || first_name
  end

end
