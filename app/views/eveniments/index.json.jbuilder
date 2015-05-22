json.array!(@eveniments) do |eveniment|
  json.extract! eveniment, :id, :title, :description, :date, :timestart, :timeend, :category, :price, :location
  json.url eveniment_url(eveniment, format: :json)
end
