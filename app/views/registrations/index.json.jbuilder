json.array!(@registrations) do |registration|
  json.extract! registration, :id, :nome, :email, :telefone, :tipo, :event_id
  json.url registration_url(registration, format: :json)
end
