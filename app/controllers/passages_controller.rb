# frozen_string_literal: true

class PassagesController < ApplicationController
  helper PassagesHelper

  before_action do
    verify_privileges(params[:action], Passage)
  end

  def new
    @passage = Passage.new
  end

  def edit
    @passage = Passage.find(params[:id])
    render :new
  end

  def index
    @passages = Passage.all
    redirect_to action: get_redirect_action
  end

  def update
    passage = Passage.find(params[:id])

    respond_to do |format|
      if passage.update_attributes(permit_params)
        flash[:success] = 'Passage was successfully updated.'
        format.html { redirect_to passages_path }
      else
        display_flash_error(passage)
        format.html { redirect_to edit_passage_path }
      end
    end
  end

  def create
    passage = Passage.new(permit_params)

    respond_to do |format|
      if passage.save
        flash[:success] = 'Passage was successfully created.'
        format.html { redirect_to passages_path }
      else
        display_flash_error(passage)
        format.html { redirect_to new_passage_path }
      end
    end
  end

  def destroy
    respond_to do |format|
      Passage.find(params[:id]).destroy
      flash[:success] = 'Passage was successfully deleted.'
      format.html { redirect_to passages_path }
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
    redirect_to ongoing_passages_path
  end

  # TODO: all the passage getter methods should give out json if asked for

  def drafts
    filtered_passages = Passage.drafts
    render 'passages/admin/passages_pane', locals: {
      filtered_passages: filtered_passages, partial_name: PassagesHelper.partial_name(:drafts)
    }
  end

  def ongoing
    filtered_passages = Passage.ongoing
    render 'passages/admin/passages_pane', locals: {
      filtered_passages: filtered_passages, partial_name: PassagesHelper.partial_name(:ongoing)
    }
  end

  def concluded
    filtered_passages = Passage.concluded
    render 'passages/admin/passages_pane', locals: {
      filtered_passages: filtered_passages, partial_name: PassagesHelper.partial_name(:concluded)
    }
  end

  def commenced
    filtered_passages = Passage.commence_for_candidate(current_user)
    render 'passages/candidate/passages_pane', locals: {
      filtered_passages: filtered_passages, partial_name: PassagesHelper.partial_name(:commenced)
    }
  end

  def missed
    filtered_passages = Passage.missed_by_candidate(current_user)
    render 'passages/candidate/passages_pane', locals: { filtered_passages: filtered_passages, partial_name: PassagesHelper.partial_name(:missed) }
  end

  def attempted
    passages = Passage.attempted_by_candidate(current_user)
    render 'passages/candidate/attempted_passages_pane', locals: { filtered_passages: passages }
  end

  private

  def get_redirect_action
    [:drafts, :ongoing, :commenced].select { |action|
      can? action, Passage
    }.first
  end

  def permit_params
    params.require('passage').permit(:title, :text, :duration, :commence_time, :conclude_time)
  end

  def display_flash_error(passage)
    flash[:danger] = passage.errors.messages.map do |m|
      m.join(' ').humanize
    end.join("\n")
  end
end
