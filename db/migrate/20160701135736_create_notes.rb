class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
        t.references :sender
        t.references :recipient
        t.text :texto
        t.string :topico
    end
  end
end
