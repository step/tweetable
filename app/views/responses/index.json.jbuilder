# frozen_string_literal: true

json.array! @responses, partial: 'responses/response', as: :response
