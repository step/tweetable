# frozen_string_literal: true

class UserGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user
end
