class SessionsController < ApplicationController
  def new
  end

  def create
  	player = Player.find_by_name(params[:name])
  	if player and player.authenticate(params[:password])
  		session[:player_id] = player.id
  		redirect_to admin_url
  	else
  		redirect_to login_url, notice: 'Wrong User Name'
  	end		
  end

  def destroy
  	session[:player_id] = nil
  	redirect_to login_url, alert: "Logged Out!"
  end

end
