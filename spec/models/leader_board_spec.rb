# frozen_string_literal: true

describe LeaderBoard, type: :model do
  context 'aggreagate the score of the users based on the weight' do
    it 'should add the score of a user and assign it as score' do
      tag1 = double('tag', weight: 5)
      tag2 = double('tag', weight: 10)
      user1 = double('user', name: 'user1', image_url: '/i', tags: [tag1, tag2])
      user2 = double('user', name: 'user2', image_url: '/i', tags: [tag1])

      expected = [{ image: '/i', name: 'user1', score: 15 },
                  { image: '/i', name: 'user2', score: 5 }]
      user_score = LeaderBoard.calculate_score([user1, user2])

      expect(user_score).to match_array(expected)
    end
  end

  context 'leader board is calculated on the basis of the points they got' do
    it 'should calculate rank of the user' do
      tag1 = double('tag', weight: 5)
      tag2 = double('tag', weight: 10)
      user1 = double('user', name: 'user1', image_url: '/i', tags: [tag1, tag2])
      user2 = double('user', name: 'user2', image_url: '/i', tags: [tag1])
      user3 = double('user', name: 'user3', image_url: '/i', tags: [tag2])
      user4 = double('user', name: 'user4', image_url: '/i', tags: [])
      user5 = double('user', name: 'user5', image_url: '/i', tags: [tag1])

      expected = [{ image: '/i', name: 'user1', score: 15, rank: 1 },
                  { image: '/i', name: 'user3', score: 10, rank: 2 },
                  { image: '/i', name: 'user5', score: 5, rank: 3 },
                  { image: '/i', name: 'user2', score: 5, rank: 3 },
                  { image: '/i', name: 'user4', score: 0, rank: 4 }]
      users = [user1, user2, user3, user4, user5]
      leader_board = LeaderBoard.generate_list(users)

      expect(leader_board).to match_array(expected)
    end

    context 'leader board is empty if no users are in the list' do
      it 'should return empty array if there are no users' do
        expected = []
        users = []
        leader_board = LeaderBoard.generate_list(users)

        expect(leader_board).to match_array(expected)
      end
    end
  end
end
