# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class AddPeopleAttrsMedicine < ActiveRecord::Migration[4.2]
    def change
      add_column :people, :medicine_vaccination, :text
      add_column :people, :medicine_stiko_vaccination, :boolean
      add_column :people, :medicine_preexisting_conditions, :text
      add_column :people, :medicine_abnormalities, :text
      add_column :people, :medicine_allergies, :text
      add_column :people, :medicine_eating_disorders, :text
      add_column :people, :medicine_mobility_needs, :text
      add_column :people, :medicine_infectious_diseases, :text
      add_column :people, :medicine_medical_treatment_contact, :text
      add_column :people, :medicine_continous_medication, :text
      add_column :people, :medicine_needs_medication, :text
      add_column :people, :medicine_medications_self_treatment, :boolean 
      add_column :people, :medicine_other, :text 
      add_column :people, :medicine_important, :text 
      add_column :people, :medicine_support, :text 
    end
end