json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :facebookid, :googleid, :calendaritem, :favoriteitem
  json.url user_url(user, format: :json)
end
