class AddToStudyCase < ActiveRecord::Migration
  def change
    add_reference :study_cases, :user, index: true, foreign_key: true
    add_attachment :study_cases, :case_file
    add_attachment :study_cases, :notes_file
  end
end
