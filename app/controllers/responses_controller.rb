class ResponsesController < ApplicationController

  def index
    passage = Passage.find(params[:passage_id])
    responses = passage.responses
    render 'index', locals: {responses: responses, passage: passage}
  end
end
