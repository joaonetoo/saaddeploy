class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :cnpj
      t.string :logradouro
      t.string :numero
      t.string :bairro
      t.string :cep
      t.string :cidade
      t.string :estado

      t.timestamps null: false
    end
  end
end
