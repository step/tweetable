class TaggingsController < ApplicationController
  before_action :set_tagging, only: [:show, :edit, :update, :destroy]

  # GET /taggings
  # GET /taggings.json
  def index
    @taggings = Tagging.all
  end

  # GET /taggings/1
  # GET /taggings/1.json
  def show
  end

  # GET /taggings/new
  def new
    @tagging = Tagging.new
  end

  # GET /taggings/1/edit
  def edit
  end

  # POST /taggings
  # POST /taggings.json
  def create
    @tagging = Tagging.new(tagging_params)

    respond_to do |format|
      if @tagging.save
        format.html { redirect_to @tagging, notice: 'Tagging was successfully created.' }
        format.json { render :show, status: :created, location: @tagging }
      else
        format.html { render :new }
        format.json { render json: @tagging.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taggings/1
  # PATCH/PUT /taggings/1.json
  def update
    respond_to do |format|
      if @tagging.update(tagging_params)
        format.html { redirect_to @tagging, notice: 'Tagging was successfully updated.' }
        format.json { render :show, status: :ok, location: @tagging }
      else
        format.html { render :edit }
        format.json { render json: @tagging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taggings/1
  # DELETE /taggings/1.json
  def destroy
    @tagging.destroy
    respond_to do |format|
      format.html { redirect_to taggings_url, notice: 'Tagging was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tagging
      @tagging = Tagging.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tagging_params
      params.require(:tagging).permit(:response_id, :tag_id)
    end
end
