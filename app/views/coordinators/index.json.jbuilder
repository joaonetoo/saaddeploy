json.array!(@coordinators) do |coordinator|
  json.extract! coordinator, :id
  json.url coordinator_url(coordinator, format: :json)
end
