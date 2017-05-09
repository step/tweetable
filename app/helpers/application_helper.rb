module ApplicationHelper
  def signed_in?
    (session.has_key? :user_id) && session[:user_id]!=nil
  end
end
