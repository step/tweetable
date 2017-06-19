# frozen_string_literal: true

json.extract! passage, :id, :created_at, :updated_at
json.url passage_url(passage, format: :json)
