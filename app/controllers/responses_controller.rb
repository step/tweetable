# frozen_string_literal: true

class ResponsesController < ApplicationController
  before_action :set_response, only: [:show]

  def index
    passage = Passage.find(params[:passage_id])
    responses = passage.responses.order('created_at DESC')
    partial = (can? :manage, Tagging) ? 'response_evaluation' : 'response'
    render 'index', locals: { responses: responses, passage: passage, partial: partial }
  end

  def show; end

  def new
    passage = Passage.find(params[:passage_id])
    user = current_user
    duration = ResponsesTracking.remaining_time(passage.id, user.id)
    render :new, locals: { passage: passage, response: passage.responses.new, user: user, remaining_time: duration }
  rescue
    redirect_to passages_path
  end

  def create
    passage = Passage.find(params[:passage_id])
    user = current_user
    remaining_time = ResponsesTracking.remaining_time(passage.id, user.id)

    @response = Response.new(response_params)
    respond_to do |format|
      if remaining_time <= 0
        flash[:danger] = 'Sorry, Your response submission time is expired!'
        format.html { redirect_to passages_path }
      elsif @response.save
        ResponsesTracking.update_end_time(params[:passage_id], current_user.id)
        flash[:success] = 'Your response was successfully recorded.'
        format.html { redirect_to passages_path }
      else
        flash[:danger] = 'Sorry, Your response was invalid!'
        format.html { redirect_to new_passage_response_path(Passage.find(params[:passage_id])) }
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
