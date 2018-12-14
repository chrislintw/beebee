require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  describe "GET #show" do
    context 'when user signed in' do
      let(:user) { create(:user) }
      before do
        sign_in user
        get :show
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it 'assigns a user' do
        expect(assigns[:user]).to eq(user)
      end
      it "renders a template" do
        expect(response).to render_template("show")
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        get :show
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #edit" do
    context 'when user signed in' do
      let(:user) { create(:user) }
      before do
        sign_in user
        get :edit
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it 'assigns a user' do
        expect(assigns[:user]).to eq(user)
      end
      it "renders a template" do
        expect(response).to render_template("edit")
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        get :edit
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT #upgrade' do
    context 'when user signed in' do
      let(:user) { create(:user) }
      before do
        sign_in user
        put :upgrade
      end

      it 'change primium to treu' do
        user.reload
        expect(user.primium).to be true
      end
      it "redirect_to profile_path" do
        expect(response).to redirect_to profile_path
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        put :upgrade
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
