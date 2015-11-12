json.array!(@streets) do |street|
  json.extract! street, :id, :name, :image
  json.url street_url(street, format: :json)
end
