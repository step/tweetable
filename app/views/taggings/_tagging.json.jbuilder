# frozen_string_literal: true

json.extract! tagging, :id, :response_id, :tag_id, :created_at, :updated_at
json.url tagging_url(tagging, format: :json)
