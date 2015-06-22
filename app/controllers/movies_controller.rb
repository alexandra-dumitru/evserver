class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
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

	for k in 0..6
		paginaZi = Nokogiri::HTML(open(zileSaptamana[k]))
		containers = paginaZi.css("div.program_cinema_show")
		containers.each do |container|
			@movie = Movie.new
			@movie.location = ""
			@movie.time = ""
			@movie.latitude = ""
			@movie.longitude = ""
			str = zileDate[k].split("-")[1]
			@movie.date = str.split(" ")[1] + " " + str.split(" ")[2][0..2] + " 2015" 
				program = container.css("div.program").children
				title = container.css("div.movie_details").css("h2").css("a")[0]['title']
				@movie.title = title
				movieURL = container.css("div.movie_details").css("h2").css("a")[0]['href']
				moviePage = Nokogiri::HTML(open(movieURL))
				description = moviePage.css("div#body_sinopsis").text.gsub(/[ăîșțâĂÎȘȚÂ]/, 'ă' => 'a', 'î' => 'i', 'ș' => 's', 'ț' => 't', 'â' => 'a', 'Ă' => 'A', 'Î' => 'I', 'Ș' => 'S', 'Ț' => 'T', 'Â' => 'A')
				@movie.description = description.lstrip!
				
				program.each do |div|
					times = div.text.scan(/[0-9]{2}:[0-9]{2}/)
					times1 = times.join("-")
					if div.css("a.theatre-link").text != "" || times1 != ""
						theatername = div.css("a.theatre-link").text
						@movie.location = @movie.location + "/" + theatername
						@movie.time = @movie.time + "/" + times1
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
						@movie.latitude = @movie.latitude + "/" + latitude
						@movie.longitude = @movie.longitude + "/" + longitude
						@movie.save
					end
				end
		end
	end

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :date, :time, :location, :latitude, :longitude)
    end
end
