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

require 'test_helper'

class WritingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
