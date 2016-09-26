json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :text, :plano_id
  json.url opportunity_url(opportunity, format: :json)
end
