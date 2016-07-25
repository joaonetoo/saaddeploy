json.array!(@videos) do |video|
  json.extract! video, :id, :description, :url, :sender_id, :recipient_id
  json.url video_url(video, format: :json)
end
