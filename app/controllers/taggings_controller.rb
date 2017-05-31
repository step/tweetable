class TaggingsController < ApplicationController
  protect_from_forgery with: :null_session

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
end
