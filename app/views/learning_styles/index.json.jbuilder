json.array!(@learning_styles) do |learning_style|
  json.extract! learning_style, :id, :nome, :descricao, :sigla
  json.url learning_style_url(learning_style, format: :json)
end
