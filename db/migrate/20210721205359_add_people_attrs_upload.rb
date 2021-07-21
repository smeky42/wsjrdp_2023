# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class AddPeopleAttrsUpload < ActiveRecord::Migration[4.2]
    def change
      add_column :people, :upload_passport_pdf, :string
      add_column :people, :upload_registration_pdf, :string
      add_column :people, :upload_sepa_pdf, :string
      add_column :people, :upload_recommondation_pdf, :string
      add_column :people, :upload_good_conduct_pdf, :string
    end
end