class Classroom < ActiveRecord::Base
    belongs_to :subject
    has_and_belongs_to_many :users
    has_and_belongs_to_many :students, association_foreign_key: 'user_id', join_table: 'classrooms_users'
    has_and_belongs_to_many :teachers, association_foreign_key: 'user_id', join_table: 'classrooms_users'
    #has_and_belongs_to_many :students,:foreign_key => 'user_id', :class_name => 'Student', :join_table => :classrooms_students
end
