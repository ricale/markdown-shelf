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

require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:default) { FactoryGirl.create(:category) }
  context "validation" do
    it { should belong_to :user}

    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }

    it { default.ordered.should == 0 }
  end
end
