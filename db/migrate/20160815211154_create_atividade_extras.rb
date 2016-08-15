class CreateAtividadeExtras < ActiveRecord::Migration
  def change
    create_table :atividade_extras do |t|
      t.string :titulo
      t.text :descricao
      t.date :data_final
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
