json.array!(@learning_results) do |learning_result|
  json.extract! learning_result, :id, :ec, :or, :ca, :ea, :student_id, :user_id, :data_final
  json.url learning_result_url(learning_result, format: :json)
end
