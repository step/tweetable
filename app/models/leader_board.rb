# frozen_string_literal: true

class LeaderBoard

  def self.generate_list(users)
    users_score = users.map do |user| {
      image: user.image_url,
        name: user.name,
        points: user.tags.reduce(0) { |score, tag| score + tag.weight.to_i } }
    end
    users_score = users_score.sort_by { |user| user[:points] }.reverse
    users_score.first[:rank] = 1
    users_score.each_with_index do |user, index|
      unless index.eql? 0
        competitor = users_score[index - 1]
        if user[:points].eql? competitor[:points]
          user[:rank] = competitor[:rank]
        else
          user[:rank] = competitor[:rank].next
        end
      end
    end
  end

end
