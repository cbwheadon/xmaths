class Game < ActiveRecord::Base
	has_many :game_players
	
	def add_game_players_from_playground(playground)
		playground.game_players.each do |player|
			game_players << player
		end
	end
end