class User < ActiveRecord::Base
  has_many :study_cases
  has_and_belongs_to_many :classrooms
  has_and_belongs_to_many :quizzes
  has_and_belongs_to_many :learning_quizzes
  has_and_belongs_to_many :study_cases
  has_attached_file :avatar, styles: { thumb: "100x100>" }, default_url: "/images/:style/semfoto.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validate :image_dimensions, :unless => "avatar.queued_for_write[:original].blank?"
  validates :nome, :telefone, :endereco, :lattes, :biografia, :matricula, :avatar, presence: true

  has_many :results
  has_many :learning_results
  has_many :sent_notes, :class_name => 'Note', :foreign_key => 'sender_id'
  has_many :received_notes, :class_name => 'Note', :foreign_key => 'recipient_id'

  has_many :sent_videos, :class_name => 'Video', :foreign_key => 'sender_id', :join_table => :videos_users
  has_and_belongs_to_many :received_videos, :class_name => 'Video', :foreign_key => 'user_id', :join_table => :videos_users

  has_many :sent_atividade_extras, :class_name => 'AtividadeExtra', :foreign_key => 'user_id', :join_table => :atividade_extras_users
  has_and_belongs_to_many :received_atividade_extras, :class_name => 'AtividadeExtra', :foreign_key => 'user_id', :join_table => :atividade_extras_users

  has_many :events, :dependent => :destroy
  has_many :answers
  has_many :answer_notes
  has_one :plano
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

private
  def image_dimensions
    required_width  = 100
    required_height = 100
    dimensions = Paperclip::Geometry.from_file(avatar.queued_for_write[:original].path)

    errors.add(:avatar, "largura deve ser 100 px") unless dimensions.width == required_width
    errors.add(:avatar, "altura deve ser 100 px") unless dimensions.height == required_height
  end

end
