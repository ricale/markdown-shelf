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

require 'rails_helper'

RSpec.describe Writing, :type => :model do

  let(:default) { FactoryGirl.create(:writing) }

  context "validation" do
    it { should belong_to :user }
    it { should belong_to :category }

    it { should validate_presence_of :user_id }
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }

    it { default.ordered.should == 0 }
    it { default.private.should == true }
  end
end
