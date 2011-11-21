class GamePlayer < ActiveRecord::Base
	belongs_to :player
	belongs_to :playground
end
