class BoardController < ApplicationController
  def index
  	@players = Player.order(:rank)
  	@playgrounds = Playground.order(:id)
  	@player = Player.find(session[:player_id])
  end
 
end
