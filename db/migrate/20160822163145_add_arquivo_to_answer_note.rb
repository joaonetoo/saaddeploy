class AddArquivoToAnswerNote < ActiveRecord::Migration
  def change
    add_attachment :answer_notes, :arquivo
  end
end
