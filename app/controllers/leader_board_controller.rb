# frozen_string_literal: true

class LeaderBoardController < ApplicationController
  def index
    users = User.where.not(auth_id: nil, admin: true, active: false)
    @leader_list = LeaderBoard.generate_list(users)
  end
end
