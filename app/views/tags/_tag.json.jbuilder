# frozen_string_literal: true

json.extract! tag, :id, :name, :weight, :color, :description
json.url tag_url(tag, format: :json)
