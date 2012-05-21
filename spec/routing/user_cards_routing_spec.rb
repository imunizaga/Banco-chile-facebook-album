require "spec_helper"

describe UserCardsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_cards").should route_to("user_cards#index")
    end

    it "routes to #new" do
      get("/user_cards/new").should route_to("user_cards#new")
    end

    it "routes to #show" do
      get("/user_cards/1").should route_to("user_cards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_cards/1/edit").should route_to("user_cards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_cards").should route_to("user_cards#create")
    end

    it "routes to #update" do
      put("/user_cards/1").should route_to("user_cards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_cards/1").should route_to("user_cards#destroy", :id => "1")
    end

  end
end
