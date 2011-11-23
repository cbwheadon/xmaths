class ContestController < ApplicationController
  def index
  	#display a random question
  	#say 1
  	@question = Question.find(1)
  	@playground = Playground.find(session[:playground_id]) 	
  end

end
