# frozen_string_literal: true

module ApplicationHelper
  def get_all_unreviewed_taggings(response)
    response.taggings.reviewed.map(& :tag)
  end
end
