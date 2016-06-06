json.array!(@principals) do |principal|
  json.extract! principal, :id
  json.url principal_url(principal, format: :json)
end
