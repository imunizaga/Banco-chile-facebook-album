require 'spec_helper'

describe "cards/edit" do
  before(:each) do
    @card = assign(:card, stub_model(Card,
      :name => "MyString",
      :source => "MyString",
      :set => 1,
      :info => "MyText"
    ))
  end

  it "renders the edit card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cards_path(@card), :method => "post" do
      assert_select "input#card_name", :name => "card[name]"
      assert_select "input#card_source", :name => "card[source]"
      assert_select "input#card_set", :name => "card[set]"
      assert_select "textarea#card_info", :name => "card[info]"
    end
  end
end
