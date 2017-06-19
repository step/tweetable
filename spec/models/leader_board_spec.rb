# frozen_string_literal: true

describe LeaderBoard, type: :model do
  context 'leader board is calculated on the basis of the credit points they got' do
    it 'should calculate rank of the user' do
      tag1 = double('tag', weight: 5)
      tag2 = double('tag', weight: 10)
      user1 = double('user', name: 'user1', image_url: 'url', tags: [tag1, tag2])
      user2 = double('user', name: 'user2', image_url: 'url', tags: [tag1])
      user3 = double('user', name: 'user3', image_url: 'url', tags: [tag2])
      user4 = double('user', name: 'user3', image_url: 'url', tags: [])
      user5 = double('user', name: 'user3', image_url: 'url', tags: [tag1])


      expected = [{image: 'url', name: 'user1', points: 15, rank: 1},
                  {image: 'url', name: 'user3', points: 10, rank: 2},
                  {image: 'url', name: 'user3', points: 5, rank: 3},
                  {image: 'url', name: 'user2', points: 5, rank: 3},
                  {image: 'url', name: 'user3', points: 0, rank: 4}]

      leader_board = LeaderBoard.generate_list(users=[user1, user2, user3, user4, user5])

      expect(leader_board).to match_array(expected)
    end
  end
end
