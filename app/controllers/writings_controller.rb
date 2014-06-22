class WritingsController < ApplicationController
  before_action :signed_in_user?

  def show
    @writing = Writing.find(params[:id])
    is_own_writing?(@writing.user_id)

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
    is_own_writing?(@writing.user_id)

    @writing.update!(writing_params)
    flash[:notice] = "Writing was successfully saved."

  rescue => e
    flash[:alert] = e.to_s
    render "shared/message"
  end

  def destroy
  end

  private

  def signed_in_user?
    if current_user.nil?
      flash[:alert] = t(:unauthenticated, scope: [:devise, :failure])
      render "shared/message"
    end
  end

  def is_own_writing?(writing_user_id)
    raise "You have no authority." unless current_user.id == writing_user_id
  end

  def writing_params
    params.require(:writing).permit(:title, :content, :category_id, :private)
  end
end
