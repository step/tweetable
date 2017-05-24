module PassagesHelper

  def admin_tabs
    {drafts: :saved, opened: :opened, closed: :closed, new: :new}
  end

  def candidate_tabs
    {open_for_candidate: :opened, attempted_by_candidate: :attempted, missed_by_candidate: :missed}
  end

  def to_preffered_time_format(time)
    time.strftime("%d-%m-%Y %H:%M%p") unless time.nil?
  end

  def to_display_time_format(time)
    time.strftime("%d %b %I:%m %p")
  end

  def duration_of_interval_in_words(interval)
    interval_time = Time.at(interval).utc.strftime("%H:%M")
    hours, minutes = interval_time.split(':').map(&:to_i)

    [].tap do |parts|
      parts << "#{hours} hour".pluralize(hours) unless hours.zero?
      parts << "#{minutes} minute".pluralize(minutes) unless minutes.zero?
    end.join(', ')
  end

end

