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
  		session[:playground_id] = playground.id
  		return playground
  			
  end
  
  private
  
  def mark_question
  	
  	@player = Player.find(session[:player_id])
    @player.update_attribute(:correct, 0)
  
    
	end
  		
end
