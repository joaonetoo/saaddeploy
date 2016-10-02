json.array!(@study_cases) do |study_case|
  json.extract! study_case, :id, :title, :author, :area, :topic, :topic2, :recommended, :abstract
  json.url study_case_url(study_case, format: :json)
end
