# frozen_string_literal: true

class ManualController < ApplicationController
  protect_from_forgery with: :exception

  def index
    current_user.is_intern ? candidate_help : admin_help
  end

  private

  def admin_help
    filename = "#{Rails.root}/docs/Manual.md"
    markup_content(filename)
  end

  def candidate_help
    filename = "#{Rails.root}/docs/StudentManual.md"
    markup_content(filename)
  end

  # TODO: pull the code to application layer if further other use case are there

  def markup_content(filename)
    contents = File.read(filename)
    renderer = Redcarpet::Render::HTML.new(autolink: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer)
    @text = markdown.render(contents).html_safe
  end
end
