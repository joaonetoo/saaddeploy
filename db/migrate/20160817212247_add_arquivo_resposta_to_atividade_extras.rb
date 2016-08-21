class AddArquivoRespostaToAtividadeExtras < ActiveRecord::Migration
  def change
    add_attachment :atividade_extras, :arquivo_resposta
    add_column :atividade_extras, :status, :string, :default => 'aberta'
  end
end
