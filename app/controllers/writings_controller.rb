class WritingsController < ApplicationController
  before_action :signed_in_user?, except: :show
  before_action :clear_flash

  def show
    @writing = Writing.with_category_name(params[:id]).first
    raise "Writing does not exist" if @writing.nil?
    raise "You have no authority." if current_user.nil? and @writing.private
    is_authorized?(@writing)

    respond_to do |format|
      format.html {
        list_data
        render "home/index"
      }
      format.json {}
    end

  rescue => e
    flash[:alert] = e.to_s
    respond_to do |format|
      format.html { render "shared/error" }
      format.json {}
    end
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
