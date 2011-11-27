class QResponsesController < ApplicationController
  # GET /q_responses
  # GET /q_responses.json
  def index
    @q_responses = QResponse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @q_responses }
    end
  end

  # GET /q_responses/1
  # GET /q_responses/1.json
  def show
    @q_response = QResponse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @q_response }
    end
  end

  # GET /q_responses/new
  # GET /q_responses/new.json
  def new
  	qid = 1
  	session[:qid]=qid
  	@question = Question.find(qid)
  	@playground = Playground.find(session[:playground_id]) 	
    @q_response = QResponse.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @q_response }
    end
  end

  # GET /q_responses/1/edit
  def edit
    @q_response = QResponse.find(params[:id])
  end

  # POST /q_responses
  # POST /q_responses.json
  def create
  	@question = Question.find(session[:qid])
  	@q_response = QResponse.new(params[:q_response])
  	if @question.number_response == @q_response.number_response
  		correct = 1
  	elsif @q_response.number_response == nil
  		correct = -1	
  	else
  		correct = 0	
  	end
  		
	@player = Player.find(session[:player_id])
	@playground = Playground.find(session[:playground_id])
	#@playground.q_responses.build(q_response: @q_response)
	@playground.q_responses << @q_response
		
	@playground.save
	
	@player.update_attribute(:number_response, @q_response.number_response)
	@player.update_attribute(:time, @q_response.q_time)
	@player.update_attribute(:correct, correct)
	
	#Check for complete response
	if  @playground.q_responses.count == 2 
		result = @playground.game_players[0].player.correct <=> @playground.game_players[1].player.correct
		#both correct	
		if result == 0 and @playground.game_players[0].player.correct == 1
			result = @playground.game_players[1].player.time <=> @playground.game_players[0].player.time
		end	
		
		if result == -1
			#player 2 wins
			@playground.game_players[0].player.update_attribute(:winner, 0)
			@playground.game_players[1].player.update_attribute(:winner, 3)
		elsif result == 1
			#player 1 wins
			@playground.game_players[0].player.update_attribute(:winner, 3)
			@playground.game_players[1].player.update_attribute(:winner, 0)
		else
			#draw
			@playground.game_players[0].player.update_attribute(:winner, 1)
			@playground.game_players[1].player.update_attribute(:winner, 1)
		end	
	
	end	
		
    respond_to do |format|
      if @q_response.save
        format.html { redirect_to @playground}
        format.js
        format.json { render json: @q_response, status: :created, location: @q_response }
      else
        format.html { render action: "new" }
        format.json { render json: @q_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /q_responses/1
  # PUT /q_responses/1.json
  def update
    @q_response = QResponse.find(params[:id])

    respond_to do |format|
      if @q_response.update_attributes(params[:q_response])
        format.html { redirect_to @q_response, notice: 'Q response was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @q_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /q_responses/1
  # DELETE /q_responses/1.json
  def destroy
    @q_response = QResponse.find(params[:id])
    @q_response.destroy

    respond_to do |format|
      format.html { redirect_to q_responses_url }
      format.json { head :ok }
    end
  end
end
