# frozen_text_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class AddIstJobs < ActiveRecord::Migration[4.2]
  def change
    create_table "ist_jobs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
      t.integer "subject_id", null: false
      t.integer "author_id", null: false
      t.text "first_choice", null: false
      t.text "second_choice", null: false
      t.text "third_choice", null: false
      t.text "first_specialization", size: :medium
      t.text "second_specialization", size: :medium
      t.text "third_specialization", size: :medium
      t.datetime "created_at"
      t.index ["subject_id"], name: "index_ist_jobs_on_subject_id"
    end
  end
end
