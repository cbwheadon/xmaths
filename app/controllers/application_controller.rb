class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_playground
  		fg = 0
  		playground = Playground
  			playgrounds = Playground.order(:id)
  			playgrounds.each do |pg|
  				if pg.game_players.count == 1
  					fg = 1
  					playground = pg
  					break
  				end
  			end	
  		if fg == 0	
  			playground = Playground.create
  		end
  		return playground
  			
  end
  		
end
