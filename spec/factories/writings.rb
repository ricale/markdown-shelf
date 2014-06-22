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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :writing do
    user_id 1
    title   "sample"
    content "this is sample"
  end
end
