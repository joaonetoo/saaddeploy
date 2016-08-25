json.array!(@matriculations) do |matriculation|
  json.extract! matriculation, :id, :nome, :email, :telefone, :tipo, :event_id
  json.url matriculation_url(matriculation, format: :json)
end
