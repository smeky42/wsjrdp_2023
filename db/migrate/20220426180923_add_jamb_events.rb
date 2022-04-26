# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class AddJambEvents < ActiveRecord::Migration[4.2]
  def change
      add_column :people, :jamb_first_event, :bool, :default => false 
      add_column :people, :jamb_second_event, :bool, :default => false 
      add_column :people, :jamb_third_event, :bool, :default => false 
      add_column :people, :jamb_fourth_event, :bool, :default => false 
      add_column :people, :jamb_precamp_event, :bool, :default => false 
  end
end
