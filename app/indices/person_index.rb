# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module PersonIndex; end

ThinkingSphinx::Index.define_partial :person do
  indexes rdp_association,
          rdp_association_region,
          rdp_association_sub_region,
          rdp_association_group,
          additional_contact_name_a,
          additional_contact_adress_a,
          additional_contact_name_b,
          additional_contact_adress_b,
          additional_contact_address_info,
          sepa_name,
          sepa_address,
          sepa_mail,
          sepa_iban,
          sepa_bic,
          sepa_status,
          unit_keys,
          unit_color,
          korea_id
end
