require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://www.cinemagia.ro/program-cinema/bucuresti/"))
output = File.open( "outputfile.yml", "w" )



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

	for k in 0..6
		paginaZi = Nokogiri::HTML(open(zileSaptamana[k]))
		output << "Pagina " + k.to_s + "\n"
		containers = paginaZi.css("div.program_cinema_show")
		containers.each do |container|
				program = container.css("div.program").children
				title = container.css("div.movie_details").css("h2").css("a")[0]['title']
				movieURL = container.css("div.movie_details").css("h2").css("a")[0]['href']
				moviePage = Nokogiri::HTML(open(movieURL))
				description = moviePage.css("div#body_sinopsis").text.gsub(/[ăîșțâĂÎȘȚÂ]/, 'ă' => 'a', 'î' => 'i', 'ș' => 's', 'ț' => 't', 'â' => 'a', 'Ă' => 'A', 'Î' => 'I', 'Ș' => 'S', 'Ț' => 'T', 'Â' => 'A')
				output << "Movie name: " + title + "\n"
				#output << "Movie description: " + description + "\n"
				program.each do |div|
					times = div.text.scan(/[0-9]{2}:[0-9]{2}/)
					times1 = times.join(" / ")
					if div.css("a.theatre-link").text != "" || times1 != ""
						theatername = div.css("a.theatre-link").text
						output << "Theater name: " + theatername + "\n"
						output << "Play time: " + times1 + "\n"
						case theatername
							when "Grand Cinema & More"
								latitude = "44.509977"
								longitude = "26.084102"
							when "Grand VIP Studios"
								latitude = "44.509977"
								longitude = "26.084102"
							when "Hollywood Multiplex"
								latitude = "44.42076"
								longitude = "26.125438"	
							when "Movieplex Cinema Plaza"
								latitude = "44.427744"
								longitude = "26.034693"	
							when "Cinema City Cotroceni"
								latitude = "44.428386"
								longitude = "26.054796"	
							when "Cine Grand Titan"
								latitude = "44.420196"
								longitude = "26.179000"
							when "Cinema City Cotroceni VIP"
								latitude = "44.428386"
								longitude = "26.054796"
							when "Cinema City Sun Plaza"
								latitude = "44.394984"
								longitude = "26.121172"
							when "Cinema City Mega Mall"
								latitude = "44.442720"
								longitude = "26.151908"
							when "T IMAX®"
								latitude = "44.428386"
								longitude = "26.054796"
							when "CinemaPRO"
								latitude = "44.434409"
								longitude = "26.102376"
							when "Cinemateca Eforie"
								latitude = "44.433797"
								longitude = "26.095642"
							when "Cinemateca Union"
								latitude = "44.437304"
								longitude = "26.096272"
							when "Corso"
								latitude = "44.434979"
								longitude = "26.10038"
							when "Elvira Popescu"
								latitude = "44.446528"
								longitude = "26.104814"
							when "Europa"
								latitude = "44.438324"
								longitude = "26.114543"
							when "Glendale Studio"
								latitude = "44.437776"
								longitude = "26.069248"
							when "Caffe Cinema 3D Patria"
								latitude = "44.442630"
								longitude = "26.099158"
							when "Patria"
								latitude = "44.442366"
								longitude = "26.098981"
							when "Scala"
								latitude = "44.440934"
								longitude = "26.099739"
							when "Studio"
								latitude = "44.445153"
								longitude = "26.097613"
							when "Movie Vip Cinema"
								latitude = "44.374401"
								longitude = "26.119481"
						end
						output << "Latitude: " + latitude + "\n"
						output << "Longitude: " + longitude + "\n"
					end
				end
			output << "\n \n"
		end
	end


str = "Program cinema  - Sâmbătă 20 Iunie"
str1 = str.split(" - ")
puts str1[1]


=begin
containers = doc.css("div.program_cinema_show")
containers.each do |container|
	if container.css("div.program").nil?
	else
		program = container.css("div.program").children
		title = container.css("div.movie_details").css("h2").css("a").text
		output << "Movie name: " + title + "\n"
		program.each do |div|
			times = div.text.scan(/[0-9]{2}:[0-9]{2}/)
			times1 = times.join(" / ")
			if div.css("a.theatre-link").text != "" || times1 != ""
				theatername = div.css("a.theatre-link").text
				output << "Theater name: " + theatername + "\n"
				
				output << "Play time: " + times1 + "\n"
			end
		end
	end
	output << "\n \n"
	
end
=end
output.close
