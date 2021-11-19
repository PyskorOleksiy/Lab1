require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'json'

require './team_matches.rb'
require './csv_files.rb'

def find_teams(doc, place)
  team_place = 0
  chosen_team = ""
  tournament = []
  doc.css('tr').each do |football_team|
    team = football_team.css('a').text
    if (team == "")
      next
    end
    team_place += 1
    team_points = football_team.css('td').last.text.to_i
    tournament.push(
      place: team_place,
      name: team,
      points: team_points
    )
    puts JSON.pretty_generate(tournament)
    
    if (team_place == place)
      some_team = football_team.css('a').text
      some_team = some_team.delete('«').delete('»')
      some_team_chars = some_team.chars
      n = some_team_chars.find_index(" ")
      some_team = some_team.delete(' ')
      chosen_team = some_team[0..n-1]
      #puts JSON.pretty_generate(chosen_team) 
    end   
  end
  
  tournament_csv(tournament)
  team_matches(chosen_team)

end