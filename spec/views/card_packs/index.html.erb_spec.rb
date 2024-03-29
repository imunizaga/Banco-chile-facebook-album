require 'spec_helper'

describe "card_packs/index" do
  before(:each) do
    assign(:card_packs, [
      stub_model(CardPack,
        :challenge_id => 1
      ),
      stub_model(CardPack,
        :challenge_id => 1
      )
    ])
  end

  it "renders a list of card_packs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
