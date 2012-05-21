require 'spec_helper'

describe "card_packs/show" do
  before(:each) do
    @card_pack = assign(:card_pack, stub_model(CardPack,
      :challenge_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
