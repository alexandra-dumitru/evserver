require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://www.cinemagia.ro/program-cinema/bucuresti/"))


counter = 1
zileSaptamana = Array.new
zileDate = Array.new
schedule = doc.css("div.nav_tabs a").map do |s|
	if counter == 8
	else
		counter = counter + 1
		zileSaptamana.push(s['href'])	
		zileDate.push(s['title'])
	end
end
#DETALII FILM
titluri = Array.new
descriptions = Array.new
programe = Array.new
cinematografe = Array.new
timeCinemas = Array.new
date = Array.new
for k in 0..6
	paginaZi = Nokogiri::HTML(open(zileSaptamana[k]))
	filmDetalii = paginaZi.css("div.program_cinema_show")
	date = zileDate[k].split(" ")[-2] + " " + zileDate[k].split(" ")[-1] + " 2015"

	for i in 0..filmDetalii.length-1
		titluri.push(filmDetalii[i].at_css("div.movie_details").at("a")['title'])
		pageForDescription = Nokogiri::HTML(open(filmDetalii[i].at_css("div.movie_details").at("a")['href']))
		descriptions.push(pageForDescription.css("div#body_sinopsis").text.gsub(/[ăîșțâĂÎȘȚÂ]/, 'ă' => 'a', 'î' => 'i', 'ș' => 's', 'ț' => 't', 'â' => 'a', 'Ă' => 'A', 'Î' => 'I', 'Ș' => 'S', 'Ț' => 'T', 'Â' => 'A'))
		programe.push(filmDetalii[i].css("div.program"))
	end
end
=begin
for j in 0..programe.length-1
	if programe[j].css("a.theatre-link").nil?
	else
		perFilmCinema = programe[j].css("a.theatre-link")
		
		for i in 0..perFilmCinema.length-1
		
			#LOCATION
			locationText = perFilmCinema[i]['title'].sub("Program ", "")
			
			
			if programe[j].text.include? locationText
				
				puts programe[j].text
				puts "-------------------"
			end
			locationPage = Nokogiri::HTML(open(perFilmCinema[i]['href']))
			if locationPage.css("div.box_content div.right").at("img.img2").nil?
			else
				locationCoordsLink =  locationPage.css("div.box_content div.right").at("img.img2")['src']
				locationCoords = locationCoordsLink[/\|(.*?)\&/]
				locationCoords.slice!(0)
				locationCoords.slice!(-1)
				latitude = locationCoords.split(",")[0]
				longitude = locationCoords.split(",")[1]
				#puts locationText + " " + latitude + " " + longitude + timeCinemas[i]
				#puts "----------------------------------------------"
			end	
		end	
	end
end
=end
str = "abc23:40mfn10:56kdckjes"
str[/[0-2][0-3]:[0-5][0-9]/]
puts str.class
#	puts e
#end
#puts "---------------------------------------"
#str = "Și sper să meargă ÂȚȘÎĂ!"
#puts str.gsub(/[ăîșțâĂÎȘȚÂ]/, 'ă' => 'a', 'î' => 'i', 'ș' => 's', 'ț' => 't', 'â' => 'a', 'Ă' => 'A', 'Î' => 'I', 'Ș' => 'S', 'Ț' => 'T', 'Â' => 'A', 'ä' => 'a', 'Ä' => '')


=begin
for i in 0..6
	paginaZi = Nokogiri::HTML(open(zileSaptamana[i]))
	cinemaLinks = paginaZi.css("a.theatre")
end
=end