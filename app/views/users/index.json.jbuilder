json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :password, :fbId, :googleId
  json.url user_url(user, format: :json)
end
