class Course < ActiveRecord::Base
  belongs_to :center
  has_many :users
  has_many :subjects
  validates :nome, :data_abertura, :turno, :center_id, presence: true

  def target_subjects
    @subjects = []
    @classrooms = current_user.classrooms
    @classrooms.each do |classroom|
        @subjects << classroom.subject
    end
    @subjects.uniq!
  end

end
