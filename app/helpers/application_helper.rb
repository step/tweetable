module ApplicationHelper
  def signed_in?
    (session.has_key? :user_id) && session[:user_id]!=nil
  end

  def duration_of_interval_in_words(interval)
    interval_time = Time.at(interval).utc.strftime("%H:%M")
    hours, minutes = interval_time.split(':').map(&:to_i)

    [].tap do |parts|
      parts << "#{hours} hour".pluralize(hours)       unless hours.zero?
      parts << "#{minutes} minute".pluralize(minutes) unless minutes.zero?
    end.join(', ')
  end
end
