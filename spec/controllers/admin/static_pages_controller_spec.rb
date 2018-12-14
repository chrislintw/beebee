require 'rails_helper'

RSpec.describe Admin::StaticPagesController, type: :controller do

  describe "GET #index" do
    let(:admin) { create(:user, admin: true) }
    it "returns http success when user is an admin" do
      sign_in admin
      get :index
      expect(response).to have_http_status(:success)
    end
    context 'when user is not an admin' do
      let(:user) { create(:user, admin: false) }
      it "redirect_to root_path" do
        sign_in user
        get :index
        expect(response).to redirect_to root_path
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
