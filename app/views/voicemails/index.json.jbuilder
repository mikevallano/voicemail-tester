json.array!(@voicemails) do |voicemail|
  json.extract! voicemail, :id, :url
  json.url voicemail_url(voicemail, format: :json)
end
