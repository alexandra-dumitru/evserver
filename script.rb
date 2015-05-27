require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('http://www.eventim.ro/ro/venues/bucuresti/city.html#s=m1&t=1&df=&dt=')

page.links.each do |link|
  puts link.text
end