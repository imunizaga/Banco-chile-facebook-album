require "spec_helper"

describe CardPacksController do
  describe "routing" do

    it "routes to #index" do
      get("/card_packs").should route_to("card_packs#index")
    end

    it "routes to #new" do
      get("/card_packs/new").should route_to("card_packs#new")
    end

    it "routes to #show" do
      get("/card_packs/1").should route_to("card_packs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/card_packs/1/edit").should route_to("card_packs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/card_packs").should route_to("card_packs#create")
    end

    it "routes to #update" do
      put("/card_packs/1").should route_to("card_packs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/card_packs/1").should route_to("card_packs#destroy", :id => "1")
    end

  end
end
