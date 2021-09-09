# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class AddMedicineNotes < ActiveRecord::Migration[4.2]
    def change
      create_table "medicine_notes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
        t.integer "subject_id", null: false
        t.integer "author_id", null: false
        t.text "text", size: :medium
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string "subject_type"
        t.index ["subject_id"], name: "index_notes_on_subject_id"
      end
    end
end


  