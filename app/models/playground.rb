class Playground < ActiveRecord::Base
	has_many :game_players, dependent: :destroy
	has_many :q_responses, dependent: :destroy
end