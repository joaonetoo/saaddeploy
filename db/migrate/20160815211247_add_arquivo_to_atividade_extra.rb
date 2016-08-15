class AddArquivoToAtividadeExtra < ActiveRecord::Migration
  def change
    add_attachment :atividade_extras, :arquivo
  end
end
