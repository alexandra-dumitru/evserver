class EventsController < ApplicationController
require 'open-uri'
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
  
  # =======================Concerte=========================
    pageNr = 1
	@category = Category.find_by name: 'Concerte'
	doc = Nokogiri::HTML(open(@category.url)) 
	nrs = doc.css("div.pages_full li.page_nocurrent").map do |nr|
		pageNr = pageNr + 1
	end
	
	1.upto(pageNr) do |id|
		url = "http://metropotam.ro/evenimente/Concerte/?start=#{id}"
		
		doc = Nokogiri::HTML(open(url))
		events = doc.css("div.event-list-item").map do |eventnode|
			titleEv = eventnode.at_css("h2").text
			#descriptionEv = eventnode.at_css("div.event-list-item-descr").text
			timeEv = eventnode.at_css("div.event-list-item-line_ex").text
			#locationEv = eventnode.at_css("span").at("//span[@itemprop = 'location']").text
			#imageSource = eventnode.at_css("img.thumb")['src']
			
			linkForEvent = eventnode.at_css("h2").at('a')['href']
			pageEvent = Nokogiri::HTML(open(linkForEvent))
			imageSource = pageEvent.css("div#movie_poster").at("//img[@itemprop = 'image']")['src']
			descriptionEv = pageEvent.css("div.text_normal").text
			
			linkForMap = pageEvent.at_css("div.movie_line").at('a')['href']
			pageMap = Nokogiri::HTML(open(linkForMap))
			if (pageMap.css("div#map").at("//meta[@itemprop = 'latitude']").nil?)
				latitude = "44.42677"
				longitude = "26.10254"
			else
				latitude = pageMap.css("div#map").at("//meta[@itemprop = 'latitude']")['content']
				longitude = pageMap.css("div#map").at("//meta[@itemprop = 'longitude']")['content']
			end
			locationEv = pageMap.at("h1").text

			@event = Event.new(event_params)
			@event.title = titleEv
			@event.description = descriptionEv
			@event.location = locationEv
			@event.date = timeEv.from(5)
			@event.category_name = "Concerte"
			@event.imagesource = imageSource
			@event.latitude = latitude
			@event.longitude = longitude
			@event.save
		end
	end
	
	#================Fetivaluri=================
	create_festivals
	#================Opera=================
	create_opera
	#================Teatru=================
	create_teatru
	#================Expozitii=================
	create_expo
	#================Party=================
	create_party
	#================Workshop=================
	create_workshop

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_festivals
	@category = Category.find_by name: 'Festivaluri'
	doc = Nokogiri::HTML(open(@category.url))
	
	events = doc.css("div.event-list-item").map do |ev|
		
		title = ev.at_css("h2").text
		#description = ev.at_css("div.event-list-item-descr").text
		date = ev.at_css("div.event-list-item-line_ex").text
		#location = ev.at_css("span").at("//span[@itemprop = 'location']").text
		startTime = date.slice(17,5)
		endTime = date.slice(37,5)
		#imageSource = ev.at_css("img.thumb")['src']
		linkForEvent = ev.at_css("h2").at('a')['href']
		pageEvent = Nokogiri::HTML(open(linkForEvent))
		imageSource = pageEvent.css("div#movie_poster").at("//img[@itemprop = 'image']")['src']
		description = pageEvent.css("div.text_normal").text
		
		linkForMap = pageEvent.at_css("div.movie_line").at('a')['href']
			pageMap = Nokogiri::HTML(open(linkForMap))
			if (pageMap.css("div#map").at("//meta[@itemprop = 'latitude']").nil?)
				latitude = "44.42677"
				longitude = "26.10254"
			else
				latitude = pageMap.css("div#map").at("//meta[@itemprop = 'latitude']")['content']
				longitude = pageMap.css("div#map").at("//meta[@itemprop = 'longitude']")['content']
			end
		location = pageMap.at("h1").text
		@event = Event.new(event_params)
		@event.title = title
		@event.description = description
		@event.timestart = startTime
		@event.timeend = endTime
		@event.date = date.from(5)
		@event.location = location
		@event.category_name = "Festivaluri"
		@event.imagesource = imageSource
		@event.latitude = latitude
		@event.longitude = longitude
		@event.save
	end
  end
  
  def create_opera
	for i in 5..12
		if (i < 10)
			url = "http://www.operanb.ro/calendar/2015-0#{i}"
			else url = "http://www.operanb.ro/calendar/2015-#{i}"
		end
		page = Nokogiri::HTML(open(url))
		events = page.css("div.calitem").map do |e|
			if(e.at_css("a"))
				title = e.at_css("a").text
				link = e.at_css("a")["href"]
				date = e.at_css("div.calzi").text
				startTime = e.at_css("div.calspecora").text
				if(link.include? "http://")
					description = link
				else description = "http://www.operanb.ro/#{link}"
				end
			time = e.at_css("div.calspecora").text
			imageSource = "http://www.operanb.ro/assets/img/logo-big.png"
			@event = Event.new(event_params)
			@event.title = title
			@event.description = description
			@event.date = date
			@event.timestart = startTime
			@event.location = "Opera Nationala Bucuresti, Bd. Mihail Kogalniceanu 70-72, sect. 5"
			@event.category_name = "Opera"
			@event.imagesource = imageSource
			@event.save
		end
	end
end
end
  
  def create_teatru
	pageNr = 1
	@category = Category.find_by name: 'Teatru'
	doc = Nokogiri::HTML(open(@category.url))
	nrs = doc.css("div.pages_full li.page_nocurrent").map do |nr|
		pageNr = pageNr + 1
	end
	
	1.upto(pageNr) do |id|
		url = "http://metropotam.ro/evenimente/Piese-de-teatru/?start=#{id}"
		
		doc = Nokogiri::HTML(open(url))
		events = doc.css("div.event-list-item").map do |eventnode|
			titleEv = eventnode.at_css("h2").text
			#descriptionEv = eventnode.at_css("div.event-list-item-descr").text
			timeEv = eventnode.at_css("div.event-list-item-line_ex").text
			#locationEv = eventnode.at_css("span").at("//span[@itemprop = 'location']").text
			#imageSource = eventnode.at_css("img.thumb")['src']
			
			linkForEvent = eventnode.at_css("h2").at('a')['href']
			pageEvent = Nokogiri::HTML(open(linkForEvent))
			imageSource = pageEvent.css("div#movie_poster").at("//img[@itemprop = 'image']")['src']
			descriptionEv = pageEvent.css("div.text_normal").text
			
			linkForMap = pageEvent.at_css("div.movie_line").at('a')['href']
			pageMap = Nokogiri::HTML(open(linkForMap))
			if (pageMap.css("div#map").at("//meta[@itemprop = 'latitude']").nil?)
				latitude = "44.42677"
				longitude = "26.10254"
			else
				latitude = pageMap.css("div#map").at("//meta[@itemprop = 'latitude']")['content']
				longitude = pageMap.css("div#map").at("//meta[@itemprop = 'longitude']")['content']
			end
			locationEv = pageMap.at("h1").text
			@event = Event.new(event_params)
			@event.title = titleEv
			@event.description = descriptionEv
			@event.location = locationEv
			@event.date = timeEv.from(5)
			@event.imagesource = imageSource
			@event.category_name = "Teatru"
			@event.latitude = latitude
			@event.longitude = longitude
			@event.save
		end
	end
  end
  
  def create_expo
	pageNr = 1
	@category = Category.find_by name: 'Expozitii'
	doc = Nokogiri::HTML(open(@category.url))
	nrs = doc.css("div.pages_full li.page_nocurrent").map do |nr|
		pageNr = pageNr + 1
	end
	
	1.upto(pageNr) do |id|
		url = "http://metropotam.ro/evenimente/Expozitii/?start=#{id}"
		
		doc = Nokogiri::HTML(open(url))
		events = doc.css("div.event-list-item").map do |eventnode|
			titleEv = eventnode.at_css("h2").text
			#descriptionEv = eventnode.at_css("div.event-list-item-descr").text
			timeEv = eventnode.at_css("div.event-list-item-line_ex").text
			#locationEv = eventnode.at_css("span").at("//span[@itemprop = 'location']").text
			#imageSource = eventnode.at_css("img.thumb")['src']
			
			linkForEvent = eventnode.at_css("h2").at('a')['href']
			pageEvent = Nokogiri::HTML(open(linkForEvent))
			imageSource = pageEvent.css("div#movie_poster").at("//img[@itemprop = 'image']")['src']
			descriptionEv = pageEvent.css("div.text_normal").text
			
			linkForMap = pageEvent.at_css("div.movie_line").at('a')['href']
			pageMap = Nokogiri::HTML(open(linkForMap))
			if (pageMap.css("div#map").at("//meta[@itemprop = 'latitude']").nil?)
				latitude = "44.42677"
				longitude = "26.10254"
			else
				latitude = pageMap.css("div#map").at("//meta[@itemprop = 'latitude']")['content']
				longitude = pageMap.css("div#map").at("//meta[@itemprop = 'longitude']")['content']
			end
			locationEv = pageMap.at("h1").text
			@event = Event.new(event_params)
			@event.title = titleEv
			@event.description = descriptionEv
			@event.location = locationEv
			@event.date = timeEv.from(5)
			@event.category_name = "Expozitii"
			@event.imagesource = imageSource
			@event.latitude = latitude
			@event.longitude = longitude
			@event.save
		end
	end
  end
  
  def create_party
	pageNr = 1
	@category = Category.find_by name: 'Party'
	doc = Nokogiri::HTML(open(@category.url))
	nrs = doc.css("div.pages_full li.page_nocurrent").map do |nr|
		pageNr = pageNr + 1
	end
	
	1.upto(pageNr) do |id|
		url = "http://metropotam.ro/evenimente/Petreceri/?start=#{id}"
		
		doc = Nokogiri::HTML(open(url))
		events = doc.css("div.event-list-item").map do |eventnode|
			titleEv = eventnode.at_css("h2").text
			#descriptionEv = eventnode.at_css("div.event-list-item-descr").text
			timeEv = eventnode.at_css("div.event-list-item-line_ex").text
			#locationEv = eventnode.at_css("span").at("//span[@itemprop = 'location']").text
			#imageSource = eventnode.at_css("img.thumb")['src']
			
			linkForEvent = eventnode.at_css("h2").at('a')['href']
			pageEvent = Nokogiri::HTML(open(linkForEvent))
			imageSource = pageEvent.css("div#movie_poster").at("//img[@itemprop = 'image']")['src']
			descriptionEv = pageEvent.css("div.text_normal").text
			
			linkForMap = pageEvent.at_css("div.movie_line").at('a')['href']
			pageMap = Nokogiri::HTML(open(linkForMap))
			if (pageMap.css("div#map").at("//meta[@itemprop = 'latitude']").nil?)
				latitude = "44.42677"
				longitude = "26.10254"
			else
				latitude = pageMap.css("div#map").at("//meta[@itemprop = 'latitude']")['content']
				longitude = pageMap.css("div#map").at("//meta[@itemprop = 'longitude']")['content']
			end
			locationEv = pageMap.at("h1").text
			@event = Event.new(event_params)
			@event.title = titleEv
			@event.description = descriptionEv
			@event.location = locationEv
			@event.date = timeEv.from(5)
			@event.category_name = "Party"
			@event.imagesource = imageSource
			@event.latitude = latitude
			@event.longitude = longitude
			@event.save
		end
	end
  end
  
  def create_workshop
	pageNr = 1
	@category = Category.find_by name: 'Workshop'
	doc = Nokogiri::HTML(open(@category.url))
	nrs = doc.css("div.pages_full li.page_nocurrent").map do |nr|
		pageNr = pageNr + 1
	end
	
	1.upto(pageNr) do |id|
		url = "http://metropotam.ro/evenimente/Petreceri/?start=#{id}"
		
		doc = Nokogiri::HTML(open(url))
		events = doc.css("div.event-list-item").map do |eventnode|
			titleEv = eventnode.at_css("h2").text
			#descriptionEv = eventnode.at_css("div.event-list-item-descr").text
			timeEv = eventnode.at_css("div.event-list-item-line_ex").text
			#locationEv = eventnode.at_css("span").at("//span[@itemprop = 'location']").text
			#imageSource = eventnode.at_css("img.thumb")['src']
			
			linkForEvent = eventnode.at_css("h2").at('a')['href']
			pageEvent = Nokogiri::HTML(open(linkForEvent))
			imageSource = pageEvent.css("div#movie_poster").at("//img[@itemprop = 'image']")['src']
			descriptionEv = pageEvent.css("div.text_normal").text
			
			linkForMap = pageEvent.at_css("div.movie_line").at('a')['href']
			pageMap = Nokogiri::HTML(open(linkForMap))
			if (pageMap.css("div#map").at("//meta[@itemprop = 'latitude']").nil?)
				latitude = "44.42677"
				longitude = "26.10254"
			else
				latitude = pageMap.css("div#map").at("//meta[@itemprop = 'latitude']")['content']
				longitude = pageMap.css("div#map").at("//meta[@itemprop = 'longitude']")['content']
			end
			locationEv = pageMap.at("h1").text
			@event = Event.new(event_params)
			@event.title = titleEv
			@event.description = descriptionEv
			@event.location = locationEv
			@event.date = timeEv.from(5)
			@event.category_name = "Workhop"
			@event.imagesource = imageSource
			@event.latitude = latitude
			@event.longitude = longitude
			@event.save
		end
	end
  end
  
  
  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :date, :timestart, :timeend, :location, :category_name, :imagesource, :latitude, :longitude)
    end
end
