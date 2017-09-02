# frozen_string_literal: true

class NotifierJOb
  def execute(notifier)
    recently_commenced = Passage.recently_commenced
    recently_commenced.each do |passage|
      notifier.notify_for_commence passage
    end
  end
end
