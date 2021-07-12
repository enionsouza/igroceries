require "rails_helper"

RSpec.describe GroceriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/groceries").to route_to("groceries#index")
    end

    it "routes to #new" do
      expect(get: "/groceries/new").to route_to("groceries#new")
    end

    it "routes to #show" do
      expect(get: "/groceries/1").to route_to("groceries#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/groceries/1/edit").to route_to("groceries#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/groceries").to route_to("groceries#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/groceries/1").to route_to("groceries#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/groceries/1").to route_to("groceries#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/groceries/1").to route_to("groceries#destroy", id: "1")
    end
  end
end
