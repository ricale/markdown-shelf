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
#  ordered     :integer          not null
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

  before_validation :default_values
  after_save :category_id_was_changed

  scope :with_category_name, -> (id) {
    joins("LEFT OUTER JOIN categories ON categories.id = writings.category_id").
    where("writings.id = ?", id).
    select("writings.*, categories.name AS category_name")
  }

  scope :ordered_by_categories, -> (user_id) {
    joins("LEFT OUTER JOIN categories ON categories.id = writings.category_id").
    where("writings.user_id = ?", user_id).
    order("categories.ordered, writings.ordered")
  }

  def default_values
    bottom_order = Writing.where(user_id: self.user_id).maximum(:ordered)
    self.ordered = bottom_order.nil? ? 0 : bottom_order + 1
    self.private = self.private.nil? ? true : self.private
    true
  end

  def category_id_was_changed
    @category_id_was_changed = category_id_changed?
  end

  def category_id_was_changed?
    @category_id_was_changed
  end
end
