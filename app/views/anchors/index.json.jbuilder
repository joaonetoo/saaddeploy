json.array!(@anchors) do |anchor|
  json.extract! anchor, :id, :nome, :descricao, :perfil, :perspectiva, :tipo, :result_id
  json.url anchor_url(anchor, format: :json)
end
