class Player < ActiveRecord::Base
	validates :name, presence:true, uniqueness: true
	has_secure_password
	has_many :game_players
end
