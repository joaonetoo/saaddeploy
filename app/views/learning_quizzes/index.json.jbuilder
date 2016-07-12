json.array!(@learning_quizzes) do |learning_quiz|
  json.extract! learning_quiz, :id, :user_id, :data_final
  json.url learning_quiz_url(learning_quiz, format: :json)
end
