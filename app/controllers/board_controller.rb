class BoardController < ApplicationController
  
	def index
		@playgrounds= Playground.all
	  	@player = Player.find(session[:player_id])
	  	
	  	rescue ActiveRecord::RecordNotFound
	  		
	  		if @player == nil
	  			@player = Player.find(15)
  				session[:player_id]=@player.id
  				session[:state]=0
	  		end 			
	end	
end
