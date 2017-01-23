class Classroom < ActiveRecord::Base
    belongs_to :subject
    validates :subject, presence: true
    validates :turno, presence: true
    validates :codigo, presence: true
    validates :ano, presence: true
    validates :semestre, presence: true
    has_and_belongs_to_many :users
    has_and_belongs_to_many :students, association_foreign_key: 'user_id', join_table: 'classrooms_users'
    has_and_belongs_to_many :teachers, association_foreign_key: 'user_id', join_table: 'classrooms_users'
    #has_and_belongs_to_many :students,:foreign_key => 'user_id', :class_name => 'Student', :join_table => :classrooms_students
end
