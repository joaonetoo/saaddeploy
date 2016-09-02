class Subject < ActiveRecord::Base
  belongs_to :course
  has_many :classrooms
  validates_associated :course
  validates :nome, :ch, :ementa, :codigo, presence: true

  def target_subjects(current_user)
    @subjects = []
    @classrooms = current_user.classrooms
    @classrooms.each do |classroom|
        @subjects << classroom.subject
    end
    @subjects.uniq!
  end
end
