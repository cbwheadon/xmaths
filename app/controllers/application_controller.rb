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
  helper_method :mark_me
  
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
  
  def mark_me
  	
  	@player = Player.find(session[:player_id])
    if @player.correct == 1
    	str = "Correct!"
    else
    	str = "Wrong!"
    end	
  	str
  	  	    
  end
	
	def new_round
		
	if session[:player_id] > 0
  	
		@player = Player.find(session[:player_id])
		
		#See if player has been assigned by another
		if @player.state == 2 and session[:state] == :inplay
			session[:state] = :assigned
			@gp = GamePlayer.find(:player_id => @player.id)
			session[:playground_id] = @gp.playground.id			
		end
		
		begin	
		#Find a partner
		@players = Player.where("state == 1 AND id != ?",@player.id).limit(1)
		rescue ActiveRecord::RecordNotFound
			#No partners available
			
		else
		
			if @players.count > 0
				@partner = @players[0]
				
				@partner.update_attribute(:state, 2)
				@player.update_attribute(:state, 2)
			
				#Make a playground for first two
				@playground = Playground.create
					
				@game_player = @playground.game_players.build("player_id" => @partner.id)
				@game_player.save
				
				@game_player = @playground.game_players.build("player_id" => @player.id)
				@game_player.save
				
				session[:state] = :assigned
				session[:playground_id] = @playground.id
				
			end
		end
	
		return(@players.count)
		
	end		
	
		return("Watching")
		
	end
  		
end
