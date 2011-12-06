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
    	str = '<div id="answer">Correct!</div>'
    else
    	str = '<div id="answer">Wrong!</div>'
    end	
  	str
  	  	    
  end
	
	def new_round
		logger.debug "Player attributes hash: #{@player.attributes.inspect}"
		case @player.state
		when 0
			#Just watching	
		when 1
			#Find a partner
			@opponents = Player.where("state == 1 AND id != ?",@player.id)
					logger.debug "Available opponents: #{@opponents.length}"
			if @opponents.length > 0
				
					a = (0...@opponents.count).to_a
	    			p1 = a.sample
	    			logger.debug "Opponent: #{p1}"
	    			@partner = @opponents[p1]
					
	    			#Error... Triggers an occasional error...
					@partner.update_attribute(:state, 2)
					@player.update_attribute(:state, 2)
				
					#Make a playground for first two
					@playground = Playground.new
					@playground.save
						
					@game_player = @playground.game_players.build("player_id" => @partner.id)
					@game_player.save
					
					@game_player = @playground.game_players.build("player_id" => @player.id)
					@game_player.save
					
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
			if session[:state] == 1
				@gp = GamePlayer.find_last_by_player_id(@player.id)
				@playground = Playground.where(@gp.playground_id).last
				session[:playground_id] = @gp.playground.id			
			end
		when 5..9
			tmp = @player.state + 1
			@player.update_attribute(:state, tmp)
						
		when 10
			@player.update_attribute(:state, 1)
		end
		
		session[:state] = @player.state
		
		return(@player.state)
		
		rescue ActiveRecord::RecordNotFound
	
			#No partners available
	end		
	
	
  		
end
