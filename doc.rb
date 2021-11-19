require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'json'

require './find_teams.rb'

#c   ruby doc.rb

url = 'https://upl.ua/ua/tournaments/championship/414/table'

html = open(url)

doc = Nokogiri::HTML(html)

place = 5
find_teams(doc, place)



