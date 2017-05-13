module PassagesHelper

  def get_passage_by_status_path(status)
    "/passages/get_passage_by_status/"+status
  end

  def to_preffered_time_format(time)
    time.strftime("%d-%m-%Y %H:%M%p") unless time.nil?
  end
end
