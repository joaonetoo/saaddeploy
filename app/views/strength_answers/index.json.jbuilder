json.array!(@strength_answers) do |strength_answer|
  json.extract! strength_answer, :id, :text, :strength_id
  json.url strength_answer_url(strength_answer, format: :json)
end
