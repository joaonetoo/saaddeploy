json.array!(@answer_notes) do |answer_note|
  json.extract! answer_note, :id, :observacao, :answer_id, :user_id
  json.url answer_note_url(answer_note, format: :json)
end
