json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :description, :date, :time, :location, :latitude, :longitude
  json.url movie_url(movie, format: :json)
end
