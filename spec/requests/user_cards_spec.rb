require 'spec_helper'

describe "UserCards" do
  describe "GET /user_cards" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get user_cards_path
      response.status.should be(200)
    end
  end
end
