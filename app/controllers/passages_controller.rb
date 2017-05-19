class PassagesController < ApplicationController
  layout false, except: [:index]

  def new
    @passage = Passage.new
  end

  def create
    @passage = Passage.new(permit_params)
    if @passage.save
      redirect_to passages_url, notice: 'Passage was successfully created.'
    else
      render :new
    end
  end

  def roll_out
    Passage.find(params[:id]).roll_out
    redirect_to :passages
  end

  def close
    Passage.find(params[:id]).close
    redirect_to :passages
  end

  #TODO all the passage getter methods should give out json if asked for

  def drafts
    filtered_passages = Passage.draft_passages
    render "passages/admin/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "drafts_passages"}
  end

  def opened
    filtered_passages = Passage.open_passages
    render "passages/admin/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "opened_passages"}
  end

  def closed
    filtered_passages = Passage.closed_passages
    render "passages/admin/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "closed_passages"}
  end

  def open_for_candidate
    user = User.find_by(auth_id: session[:user_id])
    filtered_passages = Passage.open_for_candidate(user)
    render "passages/candidate/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "opened_passages"}
  end

  def missed_by_candidate
    user = User.find_by(auth_id: session[:user_id])
    filtered_passages = Passage.missed_by_candidate(user)
    render "passages/candidate/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "missed_passages"}
  end

  def attempted_by_candidate
    user = User.find_by(auth_id: session[:user_id])
    passages = Passage.attempted_by_candidate(user)
    render "passages/candidate/attempted_passages_pane", locals: {filtered_passages: passages}
  end

  private
  def permit_params
    params.require("passage").permit(:title, :text, :duration, :start_time, :close_time)
  end
end
