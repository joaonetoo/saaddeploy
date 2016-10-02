json.array!(@questions) do |question|
  json.extract! question, :id, :statement, :user_id, :study_case_id
  json.url question_url(question, format: :json)
end
