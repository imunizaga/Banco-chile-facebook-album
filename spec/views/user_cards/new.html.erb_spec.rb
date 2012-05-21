require 'spec_helper'

describe "user_cards/new" do
  before(:each) do
    assign(:user_card, stub_model(UserCard).as_new_record)
  end

  it "renders new user_card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_cards_path, :method => "post" do
    end
  end
end
