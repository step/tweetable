# frozen_string_literal: true

class TagsController < ApplicationController
  helper_method :xeditable?

  before_action :verify_privileges, except: []

  before_action :set_tag, only: %i[show edit update destroy]
  layout false, only: %i[new edit]

  def index
    @tags = Tag.all.order('name ASC')
  end

  def show; end

  def new
    @tag = Tag.new
  end

  def edit; end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = 'Tag was successfully created.'
    else
      flash[:danger] = 'Tag was cannot be created.'
    end
    redirect_to tags_url
  end

  def update
    @tag.update(tag_params)
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def xeditable?(_object = nil)
    true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tag_params
    params.require(:tag).permit(:name, :weight, :description)
  end
end
