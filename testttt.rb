require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://www.cinemagia.ro/program-cinema/bucuresti/"))
output = File.open( "outputfile.yml", "w" )

doc.css("div.program_cinema_show").each do |container|
	if container.css("div.program").nil?
	else
		program = container.css("div.program")
		title = container.css("div.movie_details").css("h2").css("a").text
		output << "Movie name: " + title + "\n"
		
		row = program.children
		
		row.each do |row|
			theatername = row.css("a.theatre-link").text
			output << "Theater name: " + theatername + "\n"
			times = row.text.scan(/[0-2][0-3]:[0-5][0-9]/)
			times1 = times.join(" / ")
			output << "Play time: " + times1 + "\n"
		end
	end
	output << "\n \n"
	
end
output.close
