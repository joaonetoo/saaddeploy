class Student < User
    belongs_to :course
    belongs_to :institution
    belongs_to :campus
    belongs_to :center
    belongs_to :course
end
