class AtividadeExtra < ActiveRecord::Base
  belongs_to :sender, :foreign_key => 'user_id', :class_name => 'User'
  has_and_belongs_to_many :recipients, :class_name => 'User', :join_table => :atividade_extras_users
  has_many :answers
  has_attached_file :arquivo
  validates_attachment :arquivo, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }
end