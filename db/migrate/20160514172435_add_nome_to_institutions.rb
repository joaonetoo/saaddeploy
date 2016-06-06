class AddNomeToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :nome, :string
  end
end
