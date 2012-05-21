require 'spec_helper'

describe "challenges/edit" do
  before(:each) do
    @challenge = assign(:challenge, stub_model(Challenge,
      :name => "MyString",
      :n_cards => 1,
      :type => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit challenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => challenges_path(@challenge), :method => "post" do
      assert_select "input#challenge_name", :name => "challenge[name]"
      assert_select "input#challenge_n_cards", :name => "challenge[n_cards]"
      assert_select "input#challenge_type", :name => "challenge[type]"
      assert_select "textarea#challenge_description", :name => "challenge[description]"
    end
  end
end
