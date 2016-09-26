json.array!(@opportunity_answers) do |opportunity_answer|
  json.extract! opportunity_answer, :id, :text, :opportunity_id
  json.url opportunity_answer_url(opportunity_answer, format: :json)
end
