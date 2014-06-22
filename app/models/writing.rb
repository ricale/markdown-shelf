# == Schema Information
#
# Table name: writings
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  category_id :integer
#  title       :string(255)      not null
#  content     :text             not null
#  private     :boolean          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Writing < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presence_of :user_id
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :ordered
  validates_presence_of :private

  before_validation :default_values

  def default_values
    bottom_order = Writing.where(user_id: self.user_id).maximum(:ordered)
    self.ordered = bottom_order.nil? ? 0 : bottom_order + 1
    self.private ||= true
  end
end
