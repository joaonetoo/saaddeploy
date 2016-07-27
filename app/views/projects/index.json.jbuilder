json.array!(@projects) do |project|
  json.extract! project, :id, :titulo, :autor, :email, :resumo, :tags, :tipo, :estado, :event_id
  json.url project_url(project, format: :json)
end
