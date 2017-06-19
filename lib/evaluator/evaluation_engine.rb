# frozen_string_literal: true

require 'after_the_deadline'

class EvaluationEngine
  def evaluate(passage, response)
    dict = create_dict passage
    AfterTheDeadline(dict, nil)
    AfterTheDeadline.check response
  end

  def create_dict(passage)
    passage.split(' ')
  end
end
