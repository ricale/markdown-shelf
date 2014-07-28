class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def list_data
    @writings = current_user.nil? ? [] : Writing.ordered_by_categories(current_user.id)
    @writings = @writings.inject({}) do |hash, writing|
      category_id = writing.category_id || 0
      hash[category_id] = [] if hash[category_id].nil?
      hash[category_id] << writing
      hash
    end

    @categories = current_user.nil? ? [] : Category.ordered(current_user.id)
  end

  def signed_in_user?
    if current_user.nil? and !@writing.try(:private)
      flash[:alert] = t(:unauthenticated, scope: [:devise, :failure])

      respond_to do |format|
        format.html {
          list_data
          render "home/index"
        }
        format.js { render "shared/message" }
      end
    end
  end

  def is_authorized?(writing)
    raise "You have no authority." if current_user.try(:id) != writing.user_id and writing.private
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
