class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_commenter
    begin
      @current_commenter ||= Commenter.find(session[:commenter_id]) if session[:commenter_id]
    rescue
      session.delete(:commenter_id)
      @current_commenter = nil
    end
    return @current_commenter
  end
  helper_method :current_commenter

end
