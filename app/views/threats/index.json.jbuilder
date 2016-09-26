json.array!(@threats) do |threat|
  json.extract! threat, :id, :text, :plano_id
  json.url threat_url(threat, format: :json)
end
