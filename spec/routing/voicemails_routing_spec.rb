require "rails_helper"

RSpec.describe VoicemailsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/voicemails").to route_to("voicemails#index")
    end

    it "routes to #new" do
      expect(:get => "/voicemails/new").to route_to("voicemails#new")
    end

    it "routes to #show" do
      expect(:get => "/voicemails/1").to route_to("voicemails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/voicemails/1/edit").to route_to("voicemails#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/voicemails").to route_to("voicemails#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/voicemails/1").to route_to("voicemails#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/voicemails/1").to route_to("voicemails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/voicemails/1").to route_to("voicemails#destroy", :id => "1")
    end

  end
end
