json.array!(@weakness_answers) do |weakness_answer|
  json.extract! weakness_answer, :id, :text, :weakness_id
  json.url weakness_answer_url(weakness_answer, format: :json)
end
