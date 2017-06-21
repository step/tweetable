# frozen_string_literal: true

class TaggingsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :verify_privileges, only: %i[create_tagging_by_tag_name delete_tagging_by_tag_name]

  def create_tagging_by_tag_name
    tag = Tag.find_or_create_by(name: params[:tag_name])
    tag.taggings.create(response_id: params[:response_id])
    render plain: params[:tag_name]
  end

  def delete_tagging_by_tag_name
    tag = Tag.find_by(name: params[:tag_name])
    tagging = Tagging.find_by(response_id: params[:response_id], tag_id: tag.id)
    tagging.destroy
    render plain: params[:tag_name]
  end

  def review_taggings
    response = Response.find(params[:response_id])
    taggings = response.all_taggings
    taggings.update_all(reviewed: true)
    render json: taggings
  end
end
