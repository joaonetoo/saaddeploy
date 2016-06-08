class User < ActiveRecord::Base
  has_and_belongs_to_many :classrooms
  has_and_belongs_to_many :users
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/semfoto.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :results

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


end
