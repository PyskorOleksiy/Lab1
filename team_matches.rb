require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'json'

require './match_day.rb'
require './csv_files.rb'

#c   ruby doc.rb

def team_matches(chosen_team)
	url = 'https://upl.ua/ua/tournaments/championship/414/calendar'

    html = open(url)

    doc = Nokogiri::HTML(html)

    home_matches = []
    away_matches = []
    tour_match = 0
    doc.css('.tour-match').each do |team_match|
    	home_team = team_match.at_css('.first-team').text.delete(' ').gsub(/\n/, '')
        away_team = team_match.at_css('.second-team').text.delete(' ').gsub(/\n/, '')
        result = team_match.at_css('.resualt').text.delete(' ').gsub(/\n/, '')
        match_href = team_match.css('.resualt a').map{ |link| link['href'] }.compact
        match_url = match_href[0]
        away_opponent = team_match.at_css('.second-team').text.delete(' ').gsub(/\n/, '')
        home_opponent = team_match.at_css('.first-team').text.delete(' ').gsub(/\n/, '')
        if (!(result =~ /^[0-9][0-9]:[0-9][0-9]$/) && result != '-')
            if (home_team == chosen_team)
                tour_match += 1
                date_of_match = match_day(match_url)
                home_matches.push(
                    tour: tour_match,
                    day: date_of_match,
                    home: home_team,
                    result: result,
                    away: away_opponent
                )
            elsif (away_team == chosen_team)
                tour_match += 1
                match_day = match_day(match_url)
                away_matches.push(
                    tour: tour_match,
                    day: match_day,
                    home: home_opponent,
                    result: result,
                    away: away_team
                )
            end    
        end
    end
    puts "HOME MATCHES"
    puts JSON.pretty_generate(home_matches)
    puts "AWAY MATCHES"
    puts JSON.pretty_generate(away_matches)

    home_games_csv(home_matches)
    away_games_csv(away_matches)
end

