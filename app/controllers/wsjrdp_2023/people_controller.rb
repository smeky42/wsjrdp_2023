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
        :additional_contact_address_info
      ]

      # Override crud_controller
      # Display a form to edit an exisiting entry of this model.
      #   GET /entries/1/edit
      def edit(&block)
        @rdp_groups = YAML.load_file(Rails.root.join('' \
                                    '../hitobito_wsjrdp_2023/config/rdp_groups.yml'))[Rails.env]

        respond_with(entry, &block)
      end
    end
  end
end
