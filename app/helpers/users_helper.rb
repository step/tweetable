module UsersHelper
  def open_passages(user)
    (@passages - user.passages).select do |passage|
      between_time_frame?(passage)
    end
  end

  private

  def between_time_frame?(passage)
    DateTime.now.between?(passage.start_time, passage.close_time)
  end
end
