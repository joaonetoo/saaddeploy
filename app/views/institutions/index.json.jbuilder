json.array!(@institutions) do |institution|
  json.extract! institution, :id, :organizacao_academica, :categoria_administrativa, :site, :tel, :nome, :cnpj, :logradouro, :numero, :bairro, :cep, :cidade, :estado
  json.url institution_url(institution, format: :json)
end
