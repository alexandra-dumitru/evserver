require 'nokogiri'
require 'open-uri'

pageNr = 0
doc = Nokogiri::HTML(open("http://www.vinsieu.ro/evenimente/muzica-si-concerte/bucuresti/data/toate/clsdp.html"))
nrs = doc.css("div.pager a.number").map do |nr|
	pageNr = pageNr + 1
end
pageNr = pageNr/2 + 1
1.upto(pageNr) do |id|
		url = "http://www.vinsieu.ro/evenimente/muzica-si-concerte/bucuresti/data/toate/#{id}/clsdp.html"
		
		begin
		doc = Nokogiri::HTML(open(url))
		rescue Exception => e
			puts "Couldn't read \"#{ url }\": #{ e }"
			exit
		end
		puts pageNr
end

event = doc.css("div.event_content").at_css("time").at("//time[@itemprop = 'endDate']").text
titleEv = doc.css("div.event_content").at_css("p.title").text
puts "Start date: " + event
puts titleEv