# frozen_string_literal: true

json.array! @taggings, partial: 'taggings/tagging', as: :tagging
