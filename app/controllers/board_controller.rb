class BoardController < ApplicationController
  def index
  	@players = Player.order(:rank)
  	@playgrounds = Playground.order(:id)
  	@player = Player.find(session[:player_id])
  
  	rescue ActiveRecord::RecordNotFound
  		@player = nil
  		session[:player_id]=0
  		session[:playground_id]=0
  		session[:state]=:inactive
	end
end
