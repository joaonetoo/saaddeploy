class CreateQuizzesUsers < ActiveRecord::Migration
  def change
    create_table :quizzes_users, id: false  do |t|
        t.references :user, index: true, foreign_key: true
        t.references :quiz, index: true, foreign_key: true
    end
  end
end
