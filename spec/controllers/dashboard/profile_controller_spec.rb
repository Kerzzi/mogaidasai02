require 'rails_helper'

RSpec.describe Dashboard::ProfileController, type: :controller do

  describe "GET #password" do
    it "returns http success" do
      get :password
      expect(response).to have_http_status(:success)
    end
  end

end
