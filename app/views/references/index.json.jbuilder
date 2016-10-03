json.array!(@references) do |reference|
  json.extract! reference, :id, :text, :study_case_id
  json.url reference_url(reference, format: :json)
end
