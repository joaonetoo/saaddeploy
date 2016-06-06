json.array!(@subjects) do |subject|
  json.extract! subject, :id, :nome, :ch, :ementa, :codigo, :course_id
  json.url subject_url(subject, format: :json)
end
