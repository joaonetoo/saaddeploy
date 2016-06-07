json.array!(@results) do |result|
  json.extract! result, :id, :data_final, :tf, :gm, :au, :se, :ec, :sv, :ch, :ls, :student_id, :quiz_id
  json.url result_url(result, format: :json)
end
