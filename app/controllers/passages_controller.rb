class PassagesController < ApplicationController
  layout false, only: [:new, :get_passages_by_status,:roll_out]

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
    Passage.find(params[:passage_id]).roll_out
    redirect_to :passages
  end

  def get_passages_by_status
    @status = params[:status]
    @filtered_passages = helpers.query_passages_by_status(@status)
  end

  private
  def permit_params
    params.require("passage").permit(:title, :text, :duration, :start_time, :close_time)
  end
end
