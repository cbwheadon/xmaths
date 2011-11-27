#states: 
#First logged in
#	:available
#	:unavailable
#	:ready
#	:playing
#	:waiting
#	:complete

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  helper_method :new_round
  helper_method :current_playground
  
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
	
	def new_round
	
	#Find all available players
	@players = Player.where(:state => 1)
	
		if @players.count > 1
			@player1 = @players[0]
			@player2 = @players[1]
		
			@player1.update_attribute(:state, 2)
			@player2.update_attribute(:state, 2)
		
			#Make a playground for first two
			@playground = Playground.create
				
			@game_player = @playground.game_players.build("player_id" => @player1.id)
			@game_player.save
			
			@game_player = @playground.game_players.build("player_id" => @player2.id)
			@game_player.save
			
			return(@playground.game_players.count)
		end
		
	end
  		
end
