class Playground < ActiveRecord::Base
	has_many :game_players, dependent: :destroy
end
