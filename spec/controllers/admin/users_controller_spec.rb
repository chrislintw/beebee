require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  describe "GET #index" do
    context 'when user is an admin' do
      let(:admin) { create(:user, admin: true) }
      let(:user) { Admin::User.create(attributes_for(:user)) }
      before do
        sign_in admin
        get :index
      end
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      # it "assigns @users" do
      #   expect(assigns[:users]).to eq([admin, user])
      # end
      it "render template" do
        expect(response).to render_template("index")
      end
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

  describe "GET #show" do
    let(:user) { create(:user, admin: false) }
    context 'when user is not an admin' do
      it "redirect_to root_path" do
        sign_in user
        get :show, params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        get :show, params: { id: user.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  describe "PUT change_role" do
    let(:another_user) { create(:user) }
    context 'when user is not an admin' do
      let(:user) { create(:user, admin: false) }
      it "redirect_to root_path" do
        sign_in user
        put :change_role, params: {id: another_user.id}
        expect(response).to redirect_to root_path
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        put :change_role, params: {id: another_user.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
