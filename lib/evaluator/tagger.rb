# frozen_string_literal: true

class Tagger
  def generate_taggings(job, results)
    results.each do |err|
      tag = get_tag(err)
      tag.taggings.create(response_id: job.response_id)
    end
  end

  def get_tag(err)
    tag_name = err.type + ' error'
    tag = Tag.find_by(name: tag_name)
    tag || Tag.create(name: tag_name, description: err.description)
  end
end
