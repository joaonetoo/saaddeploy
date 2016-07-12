class CreateLearningQuizzes < ActiveRecord::Migration
  def change
    create_table :learning_quizzes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.date :data_final

      t.timestamps null: false
    end
  end
end
