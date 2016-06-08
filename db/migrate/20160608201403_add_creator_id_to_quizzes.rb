class AddCreatorIdToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :creator_id, :int
  end
end
