class AddTwitterAndFacebookAndLinkedinToCurriculum < ActiveRecord::Migration
  def change
    add_column :curriculums, :twitter, :string
    add_column :curriculums, :facebook, :string
    add_column :curriculums, :linkedin, :string
  end
end
