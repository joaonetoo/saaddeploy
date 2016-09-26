json.array!(@threats_answers) do |threats_answer|
  json.extract! threats_answer, :id, :text, :threat_id
  json.url threats_answer_url(threats_answer, format: :json)
end
