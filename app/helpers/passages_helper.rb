module PassagesHelper

  def to_preffered_time_format(time)
    time.strftime("%d-%m-%Y %H:%M%p") unless time.nil?
  end

  def to_display_time_format(time)
    time.strftime("%d %b %I:%m %p")
  end

end

