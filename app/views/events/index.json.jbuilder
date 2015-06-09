json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :date, :timestart, :timeend, :location, :category_name, :imagesource
  json.url event_url(event, format: :json)
end
