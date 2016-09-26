json.array!(@weaknesses) do |weakness|
  json.extract! weakness, :id, :text, :plano_id
  json.url weakness_url(weakness, format: :json)
end
