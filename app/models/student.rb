class Student < User
    belongs_to :course
    has_many :results
end
