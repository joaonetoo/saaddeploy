json.array!(@atividade_extras) do |atividade_extra|
  json.extract! atividade_extra, :id, :titulo, :descricao, :data_final, :user_id
  json.url atividade_extra_url(atividade_extra, format: :json)
end
