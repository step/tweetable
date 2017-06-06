require "que/testing"

describe "ResponseEnqueJob" do
  # after { ResponseEnqueueJob.jobs.clear }

  it "should store responses " do
    response = Response.new({id: 1, user_id: 1, passage_id: 1, text: 'sample test'})
    ResponseEnqueueJob.run
    # js = ResponseEnqueueJob.jobs

    binding.pry
    # expect(js.length).to eq(1)
    # expect(js.first["args"]).to eq([response])
    # expect(js.first['job_class']).to eq('ResponseEnqueueJob')
  end

  # it "should dequeue responses " do
  #   response = Response.new({id: 1, user_id: 1, passage_id: 1, text: 'sample test'})
  #   ResponseEnqueueJob.enqueue(response)
  #
  #   binding.pry
  #   queue_response = ResponseEnqueueJob.dequeue
  #   # js = ResponseEnqueueJob.jobs
  #   # expect(js.length).to eq(1)
  #   # expect(js.first["args"]).to eq([response])
  #   # expect(js.first['job_class']).to eq('ResponseEnqueueJob')
  # end
end