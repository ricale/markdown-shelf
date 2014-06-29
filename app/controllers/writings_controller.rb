class WritingsController < ApplicationController
  before_action :signed_in_user?
  before_action :clear_flash

  def show
    @writing = Writing.with_category_name(params[:id]).first
    puts @writing.inspect
    is_own?(@writing.user_id)

  rescue => e
    flash[:alert] = e.to_s
    render "shared/message"
  end

  def create
    @writing = Writing.new(writing_params.merge(user_id: current_user.try(:id)))

    @writing.save!
    flash[:notice] = "Writing was successfully saved."

  rescue => e
    flash[:alert] = e.to_s
    render "shared/message"
  end

  def update
    @writing = Writing.find(params[:id])
    is_own?(@writing.user_id)

    @writing.update!(writing_params)
    flash[:notice] = "Writing was successfully saved."

  rescue => e
    flash[:alert] = e.to_s
    render "shared/message"
  end

  def destroy
    writing = Writing.find(params[:id])
    is_own?(writing.user_id)

    @writing_id = writing.id
    writing.destroy!
    flash[:notice] = "Writing was successfully removed."
  rescue => e
    flash[:alert] = e.to_s
    render "shared/message"
  end

  private

  def writing_params
    params.require(:writing).permit(:title, :content, :category_id, :private)
  end
end
