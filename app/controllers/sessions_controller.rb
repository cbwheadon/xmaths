class SessionsController < ApplicationController

  def create
  	player = Player.find_by_name(params[:name])
  	if player and player.authenticate(params[:password])
  		
  		session[:player_id] = player.id
  		session[:state] = 1
  		player.update_attribute(:state, 1)
  		  		
  			respond_to do |format|
  			    format.html { redirect_to board_url }
        		format.js
  			end
  	else
  			respond_to do |format|
  			    format.html { redirect_to board_url }
        		format.js
  			end
  	end		
  end

  def destroy
  	session[:player_id] = nil
  	redirect_to login_url, alert: "Logged Out!"
  end

end
