module PassagesHelper
  OPEN = 'open'
  CLOSED = 'closed'

  def get_passage_by_status_path(status)
    "/passages/get_passage_by_status/"+status
  end

  def to_preffered_time_format(time)
    time.strftime("%d-%m-%Y %H:%M%p") unless time.nil?
  end

  def open_passages
    passage_for(OPEN)
  end

  def closed_passages
    passage_for(CLOSED)
  end

  private

  def passage_for(status)
    @passages.select do |passage|
      passage.status.downcase.eql?(status)
    end
  end
end

