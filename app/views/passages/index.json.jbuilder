# frozen_string_literal: true

json.array! @passages, partial: 'passages/passage', as: :passage
