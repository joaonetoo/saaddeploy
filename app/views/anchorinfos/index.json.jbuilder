json.array!(@anchorinfos) do |anchorinfo|
  json.extract! anchorinfo, :id, :nome, :descricao, :perfil, :perspectiva, :tipo
  json.url anchorinfo_url(anchorinfo, format: :json)
end
