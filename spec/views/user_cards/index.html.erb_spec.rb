require 'spec_helper'

describe "user_cards/index" do
  before(:each) do
    assign(:user_cards, [
      stub_model(UserCard),
      stub_model(UserCard)
    ])
  end

  it "renders a list of user_cards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
