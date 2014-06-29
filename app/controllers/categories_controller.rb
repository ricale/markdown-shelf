class CategoriesController < ApplicationController
  before_action :signed_in_user?
  before_action :clear_flash

  def create
    @category = Category.new(category_params.merge(user_id: current_user.try(:id)))

    @category.save!
    flash[:notice] = "Category was successfully saved."

  rescue => e
    flash[:alert] = e.to_s
    render "shared/message"
  end

  def update
    @category = Category.find(params[:id])
    is_own?(@category.user_id)

    @category.update!(category_params)
    flash[:notice] = "Category was successfully saved."

  rescue => e
    flash[:alert] = e.to_s
    render "shared/message"
  end

  def destroy
    category = Category.find(params[:id])
    is_own?(category.user_id)

    unless Writing.where(category_id: params[:id]).empty?
      raise "This category has some writings"
    end

    puts category.inspect

    @category_id = category.id
    category.destroy!
    flash[:notice] = "Category was successfully removed."

  rescue => e
    flash[:alert] = e.to_s
    render "shared/message"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
