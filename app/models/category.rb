# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string(255)      not null
#  ordered    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :ordered

  before_validation :default_values

  scope :ordered, -> (user_id) {
    where(user_id: user_id).
    order(:ordered)
  }

  def default_values
    bottom_order = Category.where(user_id: self.user_id).maximum(:ordered)
    self.ordered = bottom_order.nil? ? 0 : bottom_order + 1
  end
end
