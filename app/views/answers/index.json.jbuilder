json.array!(@answers) do |answer|
  json.extract! answer, :id, :observacao, :atividade_extra_id
  json.url answer_url(answer, format: :json)
end
