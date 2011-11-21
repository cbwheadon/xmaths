class AdminController < ApplicationController
  def index
  	@total_players = Player.count
  end

end
