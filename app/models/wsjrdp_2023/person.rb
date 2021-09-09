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
    Person::PUBLIC_ATTRS << :additional_contact_name_a << :additional_contact_adress_a
    Person::PUBLIC_ATTRS << :additional_contact_name_b << :additional_contact_adress_b
    Person::PUBLIC_ATTRS << :additional_contact_single << :sepa_name << :sepa_address
    Person::PUBLIC_ATTRS << :sepa_mail << :sepa_iban << :sepa_bic << :sepa_status
    Person::PUBLIC_ATTRS << :medicine_vaccination << :medicine_stiko_vaccination
    Person::PUBLIC_ATTRS << :medicine_preexisting_conditions << :medicine_abnormalities
    Person::PUBLIC_ATTRS << :medicine_allergies << :medicine_eating_disorders
    Person::PUBLIC_ATTRS << :medicine_mobility_needs << :medicine_infectious_diseases
    Person::PUBLIC_ATTRS << :medicine_medical_treatment_contact << :medicine_continous_medication
    Person::PUBLIC_ATTRS << :medicine_needs_medication << :medicine_medications_self_treatment
    Person::PUBLIC_ATTRS << :medicine_other << :medicine_important << :status
    Person::PUBLIC_ATTRS << :medicine_support << :passport_nationality << :unit_keys
    Person::PUBLIC_ATTRS << :passport_number << :passport_germany << :passport_valid
    Person::PUBLIC_ATTRS << :role_wish << :motivation << :languages_spoken
    Person::PUBLIC_ATTRS << :shirt_size << :uniform_size << :can_swim
    Person::PUBLIC_ATTRS << :medicine_status


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
