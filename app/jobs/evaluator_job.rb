require './lib/evaluator/evaluation_engine'

class EvaluatorJob
  def self.execute
    response_job = ResponseQueue.first
    return if response_job.nil?
    response = Response.find(response_job.response_id)
    passage = response.passage
    e = EvaluationEngine.new
    errors = e.evaluate(passage.text,response.text)
    response_job.destroy unless errors.nil?
    errors.each {|err|
      tag = Tag.find_or_create_by({name: err.type+' error', description: err.description, weight: -5})
      tag.taggings.create({response_id: response.id})
    }
  end
end
