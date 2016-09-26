json.array!(@strengths) do |strength|
  json.extract! strength, :id, :text, :plano_id
  json.url strength_url(strength, format: :json)
end
