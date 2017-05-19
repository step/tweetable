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
    render :new, locals: {passage: passage, response: passage.responses.new}
  rescue
    redirect_to passages_path
  end

  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        format.html {redirect_to @response, notice: 'Response was successfully created.'}
        format.json {render :show, status: :created, location: @response}
      else
        format.html {render :new}
        format.json {render json: @response.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def set_response
    @response = Response.find(params[:id])
  end

  def response_params
    params.require(:response).permit(:user_id, :passage_id, :text)
  end

end
