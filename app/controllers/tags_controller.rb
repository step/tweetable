# frozen_string_literal: true

class TagsController < ApplicationController
  helper_method :xeditable?

  before_action do
    verify_privileges(params[:action], Tag)
  end

  before_action :set_tag, only: %i[show edit update destroy]
  layout false, only: %i[new edit]

  def index
    @colors = Rails.configuration.tag_colors | Tag.select(:color).map(&:color).uniq
    @tags = Tag.all.order('name ASC')
  end

  def new
    @colors = Rails.configuration.tag_colors | Tag.select(:color).map(&:color).uniq
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = 'Tag was successfully created.'
    else
      flash[:danger] = @tag.errors.messages.map { |m| m.join(' ').humanize }.join('\n')
    end
    redirect_to tags_path
  end

  def update
    respond_to do |format|
      format.json do
        if @tag.update(tag_params)
          render json: { message: "#{@tag.name} color has been updated." }, status: :ok
        else
          render json: { error: "#{@tag.name} color has been updated." }, status: :ok
        end
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { render message: 'Tag has been updated' }
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
    params.require(:tag).permit(:name, :weight, :description, :color)
  end
end
