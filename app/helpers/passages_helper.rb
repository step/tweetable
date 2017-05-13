module PassagesHelper

  def get_passage_by_status_path(status)
    "/passages/get_passage_by_status/"+status
  end

  def query_passages_by_status(state)
    case state
      when 'DRAFT'
        Passage.where(['start_time > ?',DateTime.now]).or(Passage.where(start_time: nil))
      when 'OPENED'
        Passage.where(['start_time <= ? and close_time > ?',DateTime.now,DateTime.now])
      else
        []
    end
  end

  def to_preffered_time_format(time)
    time.strftime("%d-%m-%Y %H:%M%p")
  end
end
