class CreateAtividadeExtrasUsers < ActiveRecord::Migration
  def change
    create_table :atividade_extras_users do |t|
        t.references :user, index: true, foreign_key: true
        t.references :atividade_extra, index: true, foreign_key: true
    end
  end
end