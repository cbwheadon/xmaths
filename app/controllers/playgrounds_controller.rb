class PlaygroundsController < ApplicationController
  # GET /playgrounds
  # GET /playgrounds.json
  def index
    @playgrounds = Playground.all
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playgrounds }
    end
  end

  # GET /playgrounds/1
  # GET /playgrounds/1.json
  def show
  	@playground = Playground.find(params[:id])
	@question = Question.find(session[:qid])
	
	#Check for two valid responses
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @playground }
    end
  end

  # GET /playgrounds/new
  # GET /playgrounds/new.json
  def new
    @playground = Playground.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @playground }
    end
  end

  # GET /playgrounds/1/edit
  def edit
    @playground = Playground.find(params[:id])
  end

  # POST /playgrounds
  # POST /playgrounds.json
  def create
    @playground = Playground.new(params[:playground])

    respond_to do |format|
      if @playground.save
        format.html { redirect_to @playground, notice: 'Playground was successfully created.' }
        format.json { render json: @playground, status: :created, location: @playground }
      else
        format.html { render action: "new" }
        format.json { render json: @playground.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /playgrounds/1
  # PUT /playgrounds/1.json
  def update
    @playground = Playground.find(params[:id])
    mark_question
    #mark test
    respond_to do |format|
      if @playground.update_attributes(params[:playground])
        format.html { redirect_to @playground, notice: 'Playground was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @playground.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playgrounds/1
  # DELETE /playgrounds/1.json
  def destroy
    @playground = Playground.find(params[:id])
    @playground.destroy
	session[:playground_id]=nil
    respond_to do |format|
      format.html { redirect_to playgrounds_url }
      format.json { head :ok }
    end
  end
end
