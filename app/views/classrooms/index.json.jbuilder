json.array!(@classrooms) do |classroom|
  json.extract! classroom, :id, :subject_id, :turno, :codigo
  json.url classroom_url(classroom, format: :json)
end
