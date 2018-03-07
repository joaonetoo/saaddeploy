class Event < ActiveRecord::Base
    belongs_to :user
     validates :nome, :apresentacao, :objetivos, presence: true
    has_many :activities, :dependent => :destroy
    has_many :projects, :dependent => :destroy
    has_many :matriculations, :dependent => :destroy
    has_many :registrations, :dependent => :destroy
    has_attached_file :image, styles: { medium: "300x300>", thumb: "175x175>" }, default_url: "/assets/default.jpg"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    #validate :image_dimensions, :unless => "image.queued_for_write[:original].blank?"

    private
  def image_dimensions
    required_width  = 175
    required_height = 175
    dimensions = Paperclip::Geometry.from_file(image.queued_for_write[:original].path)

    errors.add(:image, "largura deve ser 175 px") unless dimensions.width == required_width
    errors.add(:image, "altura deve ser 175 px") unless dimensions.height == required_height
  end
end
