require 'rails_helper'

RSpec.describe ServiceController, type: :controller do

  describe "GET #agent" do
    it "returns http success" do
      get :agent
      expect(response).to have_http_status(:success)
    end
  end

end
