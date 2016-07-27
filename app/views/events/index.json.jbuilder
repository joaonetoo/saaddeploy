json.array!(@events) do |event|
  json.extract! event, :id, :nome, :apresentacao, :objetivos, :inicio, :fim, :submissao
  json.url event_url(event, format: :json)
end
