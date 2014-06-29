class HomeController < ApplicationController
  def index
    @writings = current_user.nil? ? [] : Writing.ordered_by_categories(current_user.id)
    @writings = @writings.inject({}) do |hash, writing|
      category_id = writing.category_id || 0
      hash[category_id] = [] if hash[category_id].nil?
      hash[category_id] << writing
      hash
    end

    @categories = current_user.nil? ? [] : Category.ordered(current_user.id)
  end
end
