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
  	session[:state]= 3
  	
  	@playground = Playground.find(session[:playground_id]) 	
  	@player = Player.find(session[:player_id])

	#If the playground doesn't have a question, create new, otherwise find the question
	@question = Question.where(:playground_id => @playground.id)
	if @question.count == 0
	  	
	  	@question = Question.new
		@question.stimulus = "What is ?"
	    #t.string   "image_url"
	    a = (0..100).to_a
	    p1 = a.sample
		@question.param1 = p1
		b = (0..100).to_a
	    p2 = b.sample
		@question.param2 = p2
		@question.number_response = p1 + p2
	  	@question.playground = (@playground)
	  	
	  	@question.save
	  	
  	else 
  		 @question = @question[0]
  	end
  	
  	session[:qid]=@question.id
    
  	@player.update_attribute(:state, 3)
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
  	session[:state]= 4
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
	@playground.q_responses << @q_response
		
	@playground.save
	
	@player.update_attribute(:number_response, @q_response.number_response)
	@player.update_attribute(:time, @q_response.q_time)
	@player.update_attribute(:correct, correct)
	
	@player1 = @playground.game_players[0].player
	@player2 = @playground.game_players[1].player
	
	
	#Check for complete response
	if  @playground.q_responses.count == 2 
		result = @player1.correct <=> @player2.correct
		#both correct	
		if result == 0 && @player1.correct == 1
			result = @player2.time <=> @player1.time
		end	
		
		if result == -1
			#player 2 wins
			@player1.update_attribute(:winner, 0)
			@player1.update_attribute(:inarow, 0)
			@player2.update_attribute(:winner, 3)
			@player2.update_attribute(:wins, @player2.wins + 1)
			@player2.update_attribute(:inarow, @player2.inarow + 1)
		elsif result == 1
			#player 1 wins
			@player1.update_attribute(:winner, 3)
			@player1.update_attribute(:inarow, @player1.inarow + 1)
			@player1.update_attribute(:wins, @player1.wins + 1)
			@player2.update_attribute(:winner, 0)
			@player2.update_attribute(:inarow, 0)
		else
			#draw
			@player1.update_attribute(:winner, 1)
			@player2.update_attribute(:winner, 1)
		end	
	
		@player1.update_attribute(:games, @player1.games + 1)
		@player2.update_attribute(:games, @player2.games + 1)
		
		@player1.update_attribute(:state, 5)
		@player2.update_attribute(:state, 5)
		
	else
		@player.update_attribute(:state, 4)
	end	
	
	respond_to do |format|
      if @q_response.save
        format.html { redirect_to redirect_to board_url}
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
