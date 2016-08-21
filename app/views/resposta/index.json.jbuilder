json.array!(@resposta) do |respostum|
  json.extract! respostum, :id, :observacao, :atividade_extra_id
  json.url respostum_url(respostum, format: :json)
end
