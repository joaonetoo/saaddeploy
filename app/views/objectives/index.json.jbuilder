json.array!(@objectives) do |objective|
  json.extract! objective, :id, :deadline, :text, :plano_id
  json.url objective_url(objective, format: :json)
end
