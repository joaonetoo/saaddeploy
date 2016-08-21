class Answer < ActiveRecord::Base
  belongs_to :atividade_extra
  belongs_to :user
  has_attached_file :arquivo_resposta
  validates_attachment :arquivo_resposta, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
end
