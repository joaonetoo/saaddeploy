json.array!(@line_cases) do |line_case|
  json.extract! line_case, :id, :study_case_id, :user_id, :data_final, :question_id
  json.url line_case_url(line_case, format: :json)
end
