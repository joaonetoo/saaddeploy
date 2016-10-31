class Coordinator < User
    belongs_to :course
    belongs_to :institution
    belongs_to :campus
    belongs_to :center
end
