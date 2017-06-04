class PassagesController < ApplicationController
  helper PassagesHelper


  before_action :verify_privileges, only: [:drafts, :ongoing, :finished]
  before_action :set_active_tab_and_redirect, only: [:index, :new, :drafts, :finished, :ongoing, :commenced_for_candidate, :missed_by_candidate, :attempted_by_candidate]

  NEW = 'new'
  DRAFTS = 'drafts'
  ONGOING = 'ongoing'
  COMMENCED = 'commenced'
  MISSED = 'missed'
  ATTEMPTED = 'attempted'
  FINISHED = 'concluded'


  ALL_TABS = {
      new: NEW,
      drafts: DRAFTS,
      ongoing: ONGOING,
      finished: FINISHED,
      commenced_for_candidate: COMMENCED,
      missed_by_candidate: MISSED,
      attempted_by_candidate: ATTEMPTED
  }

  def new
    @passage = Passage.new
  end

  def edit
    @passage = Passage.find(params[:id])
    render :new
  end

  def index
    @passages = Passage.all
    render :index, locals: {active_tab: current_tab}
  end

  def update
    passage = Passage.find(params[:id])

    respond_to do |format|
      if passage.update_attributes(permit_params)
        flash[:success] = 'Passage was successfully updated.'
        format.html {redirect_to passages_path}
      else
        display_flash_error(passage)
        format.html {redirect_to edit_passage_path}
      end
    end
  end

  def create
    passage = Passage.new(permit_params)

    respond_to do |format|
      if passage.save
        flash[:success] = 'Passage was successfully created.'
        format.html {redirect_to passages_path}
      else
        display_flash_error(passage)
        format.html {redirect_to new_passage_path}
      end
    end
  end

  def destroy
    respond_to do |format|
      Passage.find(params[:id]).destroy
      flash[:success] = 'Passage was successfully deleted.'
      format.html {redirect_to passages_path}
    end
  end

  def commence
    conclude_time = params[:passage][:conclude_time]
    passage = Passage.find(params[:id])
    display_flash_error(passage) unless passage.commence(conclude_time)
    redirect_to :passages
  end

  def conclude
    Passage.find(params[:id]).conclude
    redirect_to :passages
  end

  #TODO all the passage getter methods should give out json if asked for

  def drafts
    filtered_passages = Passage.drafts
    render "passages/admin/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "drafts_passages"}
  end

  def ongoing
    filtered_passages = Passage.ongoing
    render "passages/admin/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "ongoing_passages"}
  end

  def finished
    filtered_passages = Passage.finished
    render "passages/admin/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "finished_passages"}
  end

  def commenced_for_candidate
    filtered_passages = Passage.commence_for_candidate(current_user)
    render "passages/candidate/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "commenced_passages"}
  end

  def missed_by_candidate
    filtered_passages = Passage.missed_by_candidate(current_user)
    render "passages/candidate/passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "missed_passages"}
  end

  def attempted_by_candidate
    passages = Passage.attempted_by_candidate(current_user)
    render "passages/candidate/attempted_passages_pane", locals: {filtered_passages: passages}
  end

  private

  def from_tab?
    params[:from_tab].eql? 'true'
  end

  def set_active_tab_and_redirect
    set_current_tab ALL_TABS[params[:action].to_sym]
  end

  def verify_privileges
    unless current_user.admin
      set_current_tab COMMENCED
      flash[:danger] = "Either the resource you have requested does not exist or you don't have access to them"
      redirect_to passages_path
    end
  end

  def permit_params
    params.require("passage").permit(:title, :text, :duration, :commence_time, :conclude_time)
  end

  def display_flash_error(passage)
    flash[:danger] = passage.errors.messages.map do |m|
      m.join(' ').humanize
    end.join("\n")
  end

end
