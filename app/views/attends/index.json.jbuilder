json.array!(@attends) do |attend|
  json.extract! attend, :id, :userid, :eventid
  json.url attend_url(attend, format: :json)
end
