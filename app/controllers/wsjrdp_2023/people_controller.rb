# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module PeopleController
    extend ActiveSupport::Concern
    included do
      self.permitted_attrs += [
        :rdp_association,
        :rdp_association_region,
        :rdp_association_sub_region,
        :rdp_association_group,
        :rdp_association_number,
        :longitude,
        :latitude,
        :additional_contact_name_a,
        :additional_contact_adress_a,
        :additional_contact_name_b,
        :additional_contact_adress_b,
        :additional_contact_address_info,
        :additional_contact_single,
        :sepa_name,
        :sepa_address,
        :sepa_mail,
        :sepa_iban,
        :sepa_bic,
        :sepa_status,
        :medicine_vaccination,
        :medicine_stiko_vaccination,
        :medicine_preexisting_conditions,
        :medicine_abnormalities,
        :medicine_allergies,
        :medicine_eating_disorders,
        :medicine_mobility_needs,
        :medicine_infectious_diseases,
        :medicine_medical_treatment_contact,
        :medicine_continous_medication,
        :medicine_needs_medication,
        :medicine_medications_self_treatment,
        :medicine_other,
        :medicine_important,
        :medicine_support,
        :upload_passport_pdf,
        :upload_registration_pdf,
        :upload_data_processing_pdf,
        :generated_registration_pdf,
        :upload_sepa_pdf,
        :upload_recommondation_pdf,
        :upload_good_conduct_pdf,
        :passport_nationality,
        :passport_number,
        :passport_germany,
        :passport_valid,
        :status,
        :unit_keys,
        :role_wish,
        :motivation,
        :languages_spoken,
        :shirt_size,
        :uniform_size,
        :can_swim,
        :unit_color,
        :jamb_first_event, 
        :jamb_second_event, 
        :jamb_third_event, 
        :jamb_fourth_event, 
        :jamb_precamp_event
      ]

      # Override crud_controller
      # Display a form to edit an exisiting entry of this model.
      #   GET /entries/1/edit
      def edit(&block)
        @rdp_groups = YAML.load_file(Rails.root.join('' \
                                    '../hitobito_wsjrdp_2023/config/rdp_groups.yml'))[Rails.env]

        @possible_uniforms = Settings.person.shirt_sizes

        respond_with(entry, &block)
      end
    end
  end
end
