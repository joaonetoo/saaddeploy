class AddCreatorIdToLearningQuizzes < ActiveRecord::Migration
  def change
     add_column :learning_quizzes, :creator_id, :int
  end
end
