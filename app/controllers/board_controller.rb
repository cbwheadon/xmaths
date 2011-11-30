class BoardController < ApplicationController
  
	def index
		@playgrounds= Playground.all
	  	@player = Player.find(session[:player_id])
	  	
	  	rescue ActiveRecord::RecordNotFound
	  		
	  		if @player == nil
	  			@player = Player.new(:name => "Anon")
  				session[:player_id]=0
  				session[:state]=0
	  		end 			
	end	
end
