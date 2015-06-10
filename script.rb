require 'nokogiri'
require 'open-uri'
require 'mechanize'

=begin
doc = Nokogiri::HTML(open("http://www.vinsieu.ro/evenimente/muzica-si-concerte/bucuresti/data/toate/clsd.html"))
i=0
begin
concertTitle = doc.css("div.event_content p.title")[i].text
concertStartTime = doc.css("div.event_content time")[i].text
concertLocation = doc.css("div.event_content span.event_location")[i].text
concertDescription = doc.css("div.event_content span.event_summary")[i].text
i = i + 1
puts concertTitle
puts concertStartTime
puts concertLocation
puts concertDescription
puts "===================================="
end while (doc.css("p.title")[i])

events = doc.css("div.event_content").map do |eventnode|
	title = eventnode.at_css("p.title").text
	description = eventnode.at_css("span.event_summary").text
	location = eventnode.at_css("span.event_location").text
	dateEv = eventnode.at_css("time").text
end

puts events[:title]


doc = Nokogiri::HTML(open("http://metropotam.ro/evenimente/Concerte/"))


ev = doc.css("div.event-list-item").map do |f|
	title = f.at_css("h2").text
	description = f.at_css("div.event-list-item-descr").text
	time = f.at_css("div.event-list-item-line_ex").text
	location = f.at_css("span").at("//span[@itemprop = 'location']").text
	
end

pageNr = 1
nrs = doc.css("div.pages_full li.page_nocurrent").map do |nr|
	pageNr = pageNr + 1
end

page = Nokogiri::HTML(open("http://www.operanb.ro/calendar"))

events = page.css("div.calitem").map do |e|
	if(e.at_css("a"))
		title = e.at_css("a").text
		link = e.at_css("a")["href"]
		date = e.at_css("div.calzi").text
		if(link.include? "http://")
			url = link
		else url = "http://www.operanb.ro/#{link}"
		end
		
		time = e.at_css("div.calspecora").text
		
		puts title
		puts url
		puts date
		puts time
		puts "======================="
	end
	
end


json = 'http://www.operanb.ro/calendar'.to_json
result = JSON.parse(json, :quirks_mode => true)

puts result





for i in 5..12
		if (i < 10)
			url = "http://www.operanb.ro/calendar/2015-0#{i}"
			else url = "http://www.operanb.ro/calendar/2015-#{i}"
		end
end
	

str = "Cand:03 Iun 2015 19:00 - 07 Iun 2015 23:00"

startTime = str.slice(17,5)
endTime = str.slice(37,5)
startDate = str.slice(5,11)
endDate = str.

puts startDate.to_s + " - " + endDate.to_s

puts startDate.to_s
puts endDate.to_s
puts startTime.to_s
puts endTime.to_s
=end



page = Nokogiri::HTML(open("http://metropotam.ro/locuri-locatii-adrese/Arenele-Romane-loc5890124948/"))

title = page.at("h1").text
puts title








