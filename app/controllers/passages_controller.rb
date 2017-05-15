class PassagesController < ApplicationController
  layout false, only: [:new, :drafts, :closed, :opened, :roll_out]

  # GET /passages/new
  def new
    @passage = Passage.new
  end

  # # GET /passages/1/edit
  # def edit
  # end

  # POST /passages
  # POST /passages.json
  def create
    @passage = Passage.new(permit_params)
    if @passage.save
      redirect_to new_passage_url, notice: 'Passage was successfully created.'
    else
      render :new
    end
  end


  # # PATCH/PUT /passages/1
  # # PATCH/PUT /passages/1.json
  # def update
  #   respond_to do |format|
  #     if @passage.update(passage_params)
  #       format.html { redirect_to @passage, notice: 'Passage was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @passage }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @passage.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /passages/1
  # # DELETE /passages/1.json
  # def destroy
  #   @passage.destroy
  #   respond_to do |format|
  #     format.html { redirect_to passages_url, notice: 'Passage was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def roll_out
    Passage.find(params[:id]).roll_out
    redirect_to :passages
  end

  def close
    Passage.find(params[:id]).close
    redirect_to :passages
  end

  def drafts
    filtered_passages = Passage.draft_passages
    render "passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "drafts_passages"}
  end

  def opened
    filtered_passages = Passage.open_passages
    render "passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "opened_passages"}
  end

  def closed
    filtered_passages = Passage.closed_passages
    render "passages_pane", locals: {filtered_passages: filtered_passages, partial_name: "closed_passages"}
  end

  private
  def permit_params
    params.require("passage").permit(:title, :text, :duration, :start_time, :close_time)
  end
end
