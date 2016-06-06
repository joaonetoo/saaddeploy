json.array!(@courses) do |course|
  json.extract! course, :id, :nome, :data_abertura, :turno, :center_id
  json.url course_url(course, format: :json)
end
