class HomeController < ApplicationController
  def index
    @writings = current_user.nil? ? [] : Writing.where(user_id: current_user.id)
    @writings = Writing.all

    @categories = Category.all
  end
end
