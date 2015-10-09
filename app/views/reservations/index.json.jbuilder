json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :first_name, :surname, :adults_number, :children_number, :beginning, :end, :discount, :room_id
  json.url reservation_url(reservation, format: :json)
end
