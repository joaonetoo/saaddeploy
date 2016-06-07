json.array!(@quizzes) do |quiz|
  json.extract! quiz, :id, :user_id, :data_final
  json.url quiz_url(quiz, format: :json)
end
