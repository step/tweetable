# frozen_string_literal: true

json.array! @tags, partial: 'tags/tag', as: :tag
