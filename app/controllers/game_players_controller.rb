class GamePlayersController < ApplicationController
  # GET /game_players
  # GET /game_players.json
  def index
    @game_players = GamePlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_players }
    end
  end

  # GET /game_players/1
  # GET /game_players/1.json
  def show
    @game_player = GamePlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_player }
    end
  end

  # GET /game_players/new
  # GET /game_players/new.json
  def new
    @game_player = GamePlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_player }
    end
  end

  # GET /game_players/1/edit
  def edit
    @game_player = GamePlayer.find(params[:id])
  end

  # POST /game_players
  # POST /game_players.json
  def create
  	#Add player to playground
    @playground = current_playground
    #Reset player question variables
	@player = Player.find(params[:player_id])
	@player.update_attribute(:response, '')
	@player.update_attribute(:correct, -1)
	@player.update_attribute(:time, 1000)
	@player.update_attribute(:winner, -1)
	
	@game_player = @playground.game_players.build(player: @player)
	
    respond_to do |format|
      if @game_player.save
        format.html { redirect_to board_path, notice: 'Game player was successfully added.' }
        format.json { render json: @game_player, status: :created, location: @game_player }
      else
        format.html { render action: "new" }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_players/1
  # PUT /game_players/1.json
  def update
    @game_player = GamePlayer.find(params[:id])

    respond_to do |format|
      if @game_player.update_attributes(params[:game_player])
        format.html { redirect_to @game_player, notice: 'Game player was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_players/1
  # DELETE /game_players/1.json
  def destroy
    @game_player = GamePlayer.find(params[:id])
    @game_player.destroy

    respond_to do |format|
      format.html { redirect_to game_players_url }
      format.json { head :ok }
    end
  end
end
