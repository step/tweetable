module PassagesHelper

  def get_passage_by_status_path(status)
    "/passages/get_passage_by_status/"+status
  end

  def query_passages_by_status(state)
    case state
      when 'DRAFT'
        Passage.where(['start_time > ?',DateTime.now]).or(Passage.where(start_time: nil))
      when 'OPENED'
        Passage.where(['start_time > ?',DateTime.now]).or(Passage.where(['close_time < ?',DateTime.now]))
      else
        []
    end
  end

end
