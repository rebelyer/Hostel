json.array!(@rooms) do |room|
  json.extract! room, :id, :room_number, :beds_number, :price_per_adult, :price_per_child
  json.url room_url(room, format: :json)
end
