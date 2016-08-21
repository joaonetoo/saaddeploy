class AddArquivoToAnswers < ActiveRecord::Migration
  def change
    add_attachment :answers, :arquivo_resposta
  end
end
