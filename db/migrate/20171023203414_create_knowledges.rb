class CreateKnowledges < ActiveRecord::Migration
  def change
    create_table :knowledges do |t|
      t.string :descricao

      t.timestamps null: false
    end
  end
end
