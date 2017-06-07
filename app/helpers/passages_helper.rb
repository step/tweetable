module PassagesHelper

  DRAFT_PASSAGES = 'drafts_passages'

  def admin_tabs
    {drafts: :drafts, ongoing: :ongoing, finished: :concluded, new: :new}
  end

  def candidate_tabs
    {commenced: :commenced, attempted: :attempted, missed: :missed}
  end

  def to_preferred_time_format(time)
    time.strftime("%d-%m-%Y %I:%M%p") unless time.nil?
  end

  def drafts_passage_partial?(partial)
    partial.eql?(DRAFT_PASSAGES)
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

  def evaluation_count(passage_responses)
    passage_responses.map { |response|
      tags = response.tags
      !(tags.nil? || tags.empty?)
    }.count(true)
  end

end

