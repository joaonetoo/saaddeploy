json.array!(@activities) do |activity|
  json.extract! activity, :id, :data, :nome, :palestrante, :event_id
  json.url activity_url(activity, format: :json)
end
