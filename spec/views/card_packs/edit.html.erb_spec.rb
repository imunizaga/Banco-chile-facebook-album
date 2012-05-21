require 'spec_helper'

describe "card_packs/edit" do
  before(:each) do
    @card_pack = assign(:card_pack, stub_model(CardPack,
      :challenge_id => 1
    ))
  end

  it "renders the edit card_pack form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => card_packs_path(@card_pack), :method => "post" do
      assert_select "input#card_pack_challenge_id", :name => "card_pack[challenge_id]"
    end
  end
end
