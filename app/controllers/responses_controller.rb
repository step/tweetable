class ResponsesController < ApplicationController
  before_action :set_response, only: [:show]

  def index
    passage = Passage.find(params[:passage_id])
    responses = passage.responses
    render 'index', locals: {responses: responses, passage: passage}
  end

  def show
  end

  def new
    passage = Passage.find(params[:passage_id])
    render :new, locals: {passage: passage, response: passage.responses.new, user: current_user}
  rescue
    redirect_to passages_path
  end

  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        flash[:success] = 'Response was successfully created.'
        format.html {redirect_to passages_path}
      else
        flash[:error] = 'Response was invalid!'
        format.html {redirect_to new_passage_response_path(Passage.find(params[:passage_id]))}
      end
    end
  end

  private
  def set_response
    @response = Response.find(params[:id])
  end

  def response_params
    params.permit(:user_id, :passage_id, :text)
  end

end
