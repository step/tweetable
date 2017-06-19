# frozen_string_literal: true

describe LeaderBoardController, type: :routing do
  describe 'leader_board routing' do
    it 'routes to #index via GET' do
      expect(get: '/leader_board').to route_to('leader_board#index')
    end
  end
end
