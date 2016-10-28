class AddReferencesToCoordinator < ActiveRecord::Migration
  def change
    add_reference :coordinators, :institution, index: true, foreign_key: true
    add_reference :coordinators, :campu, index: true, foreign_key: true
    add_reference :coordinators, :center, index: true, foreign_key: true
  end
end
