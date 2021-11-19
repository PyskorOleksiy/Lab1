require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'json'
require 'rexml/document' 
require 'date'

#c   ruby doc.rb

def match_day(match_url)

	rel_direct = "https://upl.ua"

    url = rel_direct + match_url

    html = open(url)

    doc = Nokogiri::HTML(html)

    #match_day = doc.css('.time').text.gsub(/[а-яА-Я]/, '').delete('і').delete(',').delete('`') 
    match_day = doc.css('.time').text 

    return match_day
end