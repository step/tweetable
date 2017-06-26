# frozen_string_literal: true

class HelpController < ApplicationController
  protect_from_forgery with: :exception

  def index
    current_user.admin ? admin_help : candidate_help
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

  def markup_content(filename)
    contents = File.read(filename)
    renderer = Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer)
    @text = markdown.render(contents).html_safe
  end
end
