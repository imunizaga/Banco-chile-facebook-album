require 'spec_helper'

describe "challenges/new" do
  before(:each) do
    assign(:challenge, stub_model(Challenge,
      :name => "MyString",
      :n_cards => 1,
      :type => 1,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new challenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => challenges_path, :method => "post" do
      assert_select "input#challenge_name", :name => "challenge[name]"
      assert_select "input#challenge_n_cards", :name => "challenge[n_cards]"
      assert_select "input#challenge_type", :name => "challenge[type]"
      assert_select "textarea#challenge_description", :name => "challenge[description]"
    end
  end
end
