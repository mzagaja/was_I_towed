json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :vehicle_license, :telephone_number
  json.url user_url(user, format: :json)
end
