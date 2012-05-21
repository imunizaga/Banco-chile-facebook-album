require 'spec_helper'

describe "user_cards/show" do
  before(:each) do
    @user_card = assign(:user_card, stub_model(UserCard))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
