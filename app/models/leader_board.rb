# frozen_string_literal: true

class LeaderBoard
  class << self
    def generate_list(users)
      return [] if users.empty?
      users_score = calculate_score(users).sort_by { |user| user[:score] }.reverse

      users_score.first[:rank] = 1
      users_score.each_with_index do |user, index|
        next if index.eql? 0
        competitor = users_score[index.pred]
        user[:rank] = assign_rank(user, competitor)
      end
    end

    def calculate_score(users)
      users.map do |user|
        {
          image: user.image_url,
          name: user.name,
          score: user.tags.reduce(0) { |score, tag| score + tag.weight.to_i }
        }
      end
    end

    private

    def equal_points?(user, competitor)
      user[:score].eql? competitor[:score]
    end

    def assign_rank(user, competitor)
      equal_points?(user, competitor) ? competitor[:rank] : competitor[:rank].next
    end
  end
end
