class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def signed_in_user?
    if current_user.nil?
      flash[:alert] = t(:unauthenticated, scope: [:devise, :failure])
      render "shared/message"
    end
  end

  def is_own?(owner_user_id)
    raise "You have no authority." unless current_user.id == owner_user_id
  end

  def clear_flash
    flash[:alert]  = nil
    flash[:info]   = nil
    flash[:notice] = nil
  end
end
