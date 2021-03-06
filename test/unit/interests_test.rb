require 'test_helper'

class InterestTest < ActiveSupport::TestCase

  should belong_to(:person)
  should validate_presence_of(:person_id)
  should validate_presence_of(:name)
  should validate_presence_of(:provider)
  should validate_presence_of(:interest_id)
  should validate_presence_of(:person_id)
  should validate_presence_of(:category)
  
  context "an interest" do
    setup do
      @person = Factory(:person)
    end
    should "be able to add an interest" do
      interest1 = @person.interests.create(:provider => "facebook", :name => "Books", :person_id => @person.personID.to_i, :interest_id => "1", :category => "Things")
      assert interest1.valid?
    end
  end    
end
