class Principal < User
    belongs_to :institution
    has_many :campus, through: :institution
end
