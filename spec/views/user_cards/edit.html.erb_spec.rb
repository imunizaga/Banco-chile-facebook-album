require 'spec_helper'

describe "user_cards/edit" do
  before(:each) do
    @user_card = assign(:user_card, stub_model(UserCard))
  end

  it "renders the edit user_card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_cards_path(@user_card), :method => "post" do
    end
  end
end
