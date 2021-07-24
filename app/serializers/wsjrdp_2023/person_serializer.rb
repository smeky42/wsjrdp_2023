# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023::PersonSerializer
  extend ActiveSupport::Concern
  included do
    extension(:details) do |_|
      map_properties :old_id,
                     :rdp_association,
                     :rdp_association_region,
                     :rdp_association_sub_region,
                     :rdp_association_group,
                     :rdp_association_number,
                     :additional_contact_name_a,
                     :additional_contact_adress_a,
                     :additional_contact_name_b,
                     :additional_contact_adress_b,
                     :additional_contact_address_info,
                     :sepa_name,
                     :sepa_address,
                     :sepa_mail,
                     :sepa_iban,
                     :sepa_bic,
                     :sepa_status,
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
                     :uniform_size
    end
  end
end
