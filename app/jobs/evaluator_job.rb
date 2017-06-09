require './lib/evaluator/evaluation_engine'

class EvaluatorJob
  def self.execute
    response_job = ResponseQueue.first
    return if response_job.nil?
    evaluate response_job
    response_job.destroy
  end

  def self.evaluate response_job
    response = Response.find(response_job.response_id)
    passage = response.passage
    e = EvaluationEngine.new
    errors = e.evaluate(passage.text,response.text)
    errors.each {|err|
      tagger err.type
    }
  end

  def self.tagger tag_name
    tag = Tag.find_or_create_by(name: tag_name+' Error')
    tag.taggings.create({response_id: response.id})
  end

end
