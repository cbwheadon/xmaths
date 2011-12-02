#states: 
#First logged in
#	0:watching
#	1:waiting
#	2:assigned
#	3:playing
#	4:waiting for other answer
#	5:complete

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
		
		case @player.state
		when 0
			#Just watching	
		when 1
			#Find a partner
			@players = Player.where("state == 1 AND id != ?",@player.id).limit(1)
						
			if @players.count > 0
					@partner = @players[0]
					
					@partner.update_attribute(:state, 2)
					@player.update_attribute(:state, 2)
				
					#Make a playground for first two
					@playground = Playground.new
					@playground.save
						
					@game_player = @playground.game_players.build("player_id" => @partner.id)
					@game_player.save
					
					@game_player = @playground.game_players.build("player_id" => @player.id)
					@game_player.save
					
					session[:state] = 2
					session[:playground_id] = @playground.id
					
					@player.update_attribute(:number_response, 0)
					@player.update_attribute(:correct, -1)
					@player.update_attribute(:time, 1000)
					@player.update_attribute(:winner, -1)
					
					@partner.update_attribute(:number_response, 0)
					@partner.update_attribute(:correct, -1)
					@partner.update_attribute(:time, 1000)
					@partner.update_attribute(:winner, -1)
					
			end
		when 2
			#See if player has been assigned by another
			#if session[:state] == 1
			#	session[:state] = 2
			#	@gp = GamePlayer.find(:player_id => @player.id)
			#	session[:playground_id] = @gp.playground.id			
			#end
		when 5..9
			tmp = @player.state + 1
			@player.update_attribute(:state, tmp)
			
		when 10
			@player.update_attribute(:state, 1)
		end
		
		return(Time.new)
		
		rescue ActiveRecord::RecordNotFound
	
			#No partners available
	end		
	
	
  		
end
