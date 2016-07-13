class CreateLearningQuizzesUsers < ActiveRecord::Migration
  def change
    create_table :learning_quizzes_users, id: false  do |t|
        t.references :user, index: true, foreign_key: true
        t.references :learning_quiz, index: true, foreign_key: true
    end
  end
end
