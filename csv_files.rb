require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'json'
require 'csv'
require 'fastcsv'

def tournament_csv(tournament)
	CSV.open("./tournament.csv", "w", headers: true) do |csv|
		t_headers = ["Місце", "Клуб", "Очки"]
		csv << t_headers
		for club in tournament do
			csv << club.values
		end	
    end 
end

def home_games_csv(home_matches)
    CSV.open("./home_games.csv", "w", headers: true) do |csv|
    	m_headers = ["Тур", "Дата", "Господарі", "Рахунок", "Гості"]
		csv << m_headers
		for game in home_matches do
			csv << game.values
		end
    end
end

def away_games_csv(away_matches)
    CSV.open("./away_games.csv", "w", headers: true) do |csv|
    	m_headers = ["Тур", "Дата", "Господарі", "Рахунок", "Гості"]
		csv << m_headers
		for game in away_matches do
			csv << game.values
		end
    end
end