class BoardController < ApplicationController
  def index
  	@players = Player.order(:rank)
  	@playgrounds = Playground.order(:id)
  end

end
