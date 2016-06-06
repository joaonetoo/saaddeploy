class AddTelToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :tel, :string
    add_column :institutions, :organizacao_academica, :string
    add_column :institutions, :categoria_administrativa, :string
    add_column :institutions, :site, :string
  end
end
