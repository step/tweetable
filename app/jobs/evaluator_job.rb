class EvaluatorJob
  def execute (queue, engine, tagger)
    # pull response from the queue
    response_job = queue.fetch
    return if response_job.nil?

    # get response text and passage text
    response = Response.find(response_job.response_id)
    passage = response.passage

    # evaluating using given engine
    results = engine.evaluate(passage.text, response.text)

    # generating taggings
    tagger.generate_taggings response, results

    # acknowledge the queue
    queue.ack(response_job)
  end
end
