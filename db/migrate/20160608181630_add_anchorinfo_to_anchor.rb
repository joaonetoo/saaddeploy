class AddAnchorinfoToAnchor < ActiveRecord::Migration
  def change
    add_reference :anchors, :anchorinfo, index: true, foreign_key: true
  end
end
