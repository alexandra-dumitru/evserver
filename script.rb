require 'nokogiri'
require 'open-uri'

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


doc = Nokogiri::HTML(open("http://www.cinemagia.ro/program-cinema/bucuresti/premiere/"))

movieLinks = doc.css("div.box_list_programe_cinema").map do |m|
	moviePageURL = m.at_css("a")['href']
	moviePage = Nokogiri::HTML(open(moviePage))
	title = moviePage.css("h1").text
	description = moviePage.css("div#body_sinopsis").text
	date = 
	timeStart
	timeEnd
	location
	categoryName
	imageSource
	latitude
	longitude
	eventURLh
	
	moviePageURL = movieDayPage.css("h2 a").map do |m|
		moviePage = Nokogiri::HTML(open(m['href']))
		
	end
end
=end


doc = Nokogiri::HTML(open("http://www.cinemagia.ro/program-cinema/bucuresti/"))

counter = 1
schedule = doc.css("div.nav_tabs a").map do |s|
	if counter == 8
	else
		counter = counter + 1
		#@movie = Movie.new
		movieDayPage = Nokogiri::HTML(open(s['href']))
		dateS = s['title'].split(" ")[-2] + " " + s['title'].split(" ")[-1] + " 2015"
		date = dateS.slice(0,6)
		
		#Movie details start
		movieItem = movieDayPage.css("div.program_cinema_show").map do |m|
		#TITLE
			title = m.at_css("div.image").at("a")['title'].split("-")[1].lstrip!
		#DESCRIPTION
			movieLink = m.at_css("div.image").at("a")['href']
			moviePage = Nokogiri::HTML(open(movieLink))
			description = moviePage.css("div#body_sinopsis").text
			
			program = movieDayPage.css("div.program a")
			for i in 0..program.length-1
				puts program[i]['href']
			end
			
		
=begin					
			programMap = m.at_css("div.program").map do |p|
				if p.at("a.theatre-link").nil?
				else
					locationText1 = locationText1 + "," + p.at("a.theatre-link")['title']
					puts locationText1
				end
				if p.at("a.buy_ticket_hour").nil?
				else
					locationHours = locationHours + "," + p.at("a.buy_ticket_hour").text
					puts locationHours
				end
			end
=end				
				
				
				#@movie.location = locationText
				locationURL = m.at_css("div.program").at("a.theatre-link")['href']
				locationPage = Nokogiri::HTML(open(locationURL))
				if locationPage.css("div.box_content div.right").nil?
					
				else  
					if locationPage.css("div.box_content div.right").at("img.img2").nil?
					#puts "it is nil"
					else 
						locationCoordsLink =  locationPage.css("div.box_content div.right").at("img.img2")['src']
						locationCoords = locationCoordsLink[/\|(.*?)\&/]
						locationCoords.slice!(0)
						locationCoords.slice!(-1)
						latitude = locationCoords.split(",")[0]
						longitude = locationCoords.split(",")[1]
						#@movie.latitude = latitude
						#@movie.longitude = longitude
						#puts locationText + " " + latitude + " " + longitude
					end
				end	
			end		
		end		
		#Movie details end
	end

=begin
	if counter == 8
	else
		counter = counter + 1
		dateS = s['title'].split(" ")[-2] + " " + s['title'].split(" ")[-1]
		date = dateS.slice(0,6)
		#Begin search movie by movie
	    moviePageURL = movieDayPage.css("h2 a").map do |m|
		moviePage = Nokogiri::HTML(open(m['href']))
		puts m['href']
		title = moviePage.css('h1').text
		description = moviePage.css("div#body_sinopsis").text
		timeStart = moviePage.css("div.program span").text
		#puts moviePage.css("div.program").at_css("a.theatre-link")['title']
		
		
	end
	

		#Location start

		location = moviePage.css("div.program").at_css("a.theatre-link")['title']
		locationURL = moviePage.css("div.program").at_css("a.theatre-link")['href']
		cinemaPage = Nokogiri::HTML(open(locationURL))
		locationCoordsLink = cinemaPage.css("div.box_content").text
		locationCoords = locationCoordsLink[/\|(.*?)\&/]
		locationCoords.slice!(0)
		locationCoords.slice!(-1)
		latitude = locationCoords.split(",")[0]
		longitude = locationCoords.split(",")[1]
		
		#puts latitude
		#puts longitude


		#Location end
		
	end
=end




