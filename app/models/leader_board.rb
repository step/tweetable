# frozen_string_literal: true

# This class Manages the Leader Board
class LeaderBoard
<<<<<<< 86b8792d929b3737f82da93af95d5392de274692
  class << self
  def generate_list(users)
    users_score = calculate_score(users).sort_by { |user| user[:score] }.reverse
=======
  def self.generate_list(users)
    users_score = users.map do |user| {
      image: user.image_url,
        name: user.name,
        points: user.tags.reduce(0) { |score, tag| score + tag.weight.to_i } }
    end
    users_score = users_score.sort_by { |user| user[:points] }.reverse
>>>>>>> [Dharmenn] UnusedMethodArgument, NestedParenthesizedCalls, MethodDefParentheses, EmptyLinesAroundClassBody, IndentationWidth, IndentationConsistency, LeadingCommentSpace, CommentAnnotation, TrailingWhitespace, PercentLiteralDelimiters, SpaceInsideBlockBraces, RedundantSelf, VariableName, EmptyLinesAroundModuleBody, SpaceBeforeFirstArg issue
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
<<<<<<< 86b8792d929b3737f82da93af95d5392de274692

    private

  def equal_points?(user, competitor)
    user[:score].eql? competitor[:score]
  end

  def assign_rank(user, competitor)
    equal_points?(user, competitor) ? competitor[:rank] : competitor[:rank].next
  end
end
=======
>>>>>>> [Dharmenn] UnusedMethodArgument, NestedParenthesizedCalls, MethodDefParentheses, EmptyLinesAroundClassBody, IndentationWidth, IndentationConsistency, LeadingCommentSpace, CommentAnnotation, TrailingWhitespace, PercentLiteralDelimiters, SpaceInsideBlockBraces, RedundantSelf, VariableName, EmptyLinesAroundModuleBody, SpaceBeforeFirstArg issue
end
