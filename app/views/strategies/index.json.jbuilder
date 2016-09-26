json.array!(@strategies) do |strategy|
  json.extract! strategy, :id, :deadline, :text, :objective_id
  json.url strategy_url(strategy, format: :json)
end
