require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  
  describe "GET #index" do
    context 'when user is an admin' do
      let(:admin) { create(:user, admin: true) }
      let(:products) { create_list(:product, 10, created_by: admin) }
      before do
        sign_in admin
        get :index
      end
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns @products" do
        expect(products.count).to eq(10)
      end

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

  describe "GET #new" do
    context 'when user is an admin' do
      let(:admin) { create(:user, admin: true) }
      before do
        sign_in admin
        get :new
      end
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      # it "assigns @admin_product" do
      #   expect(assigns[:admin_product]).to be_a_new(Admin::Product)
      # end

      it "render template" do
        expect(response).to render_template("new")
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, admin: false) }
      it "redirect_to root_path" do
        sign_in user
        get :new
        expect(response).to redirect_to root_path
      end
    end
    
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  describe "POST #create" do
    context 'when user is an admin' do
      let(:admin) { create(:user, admin: true) }
      before do
        sign_in admin
      end
      
      it 'creates a new product if the params is correct' do
        expect do
          post :create, params: { admin_product: attributes_for(:product) }
        end.to change { Admin::Product.count }.by(1)
      end

      it "cannot create a new product if the params is incorrect" do
        expect do
          post :create, params: { admin_product: { name: nil, price: nil } }
        end.to change { Admin::Product.count }.by(0)
      end
    end

    context 'when user is not an admin' do
      let(:user) { create(:user, admin: false) }
      it "redirect_to root_path" do
        sign_in user
        post :create
        expect(response).to redirect_to root_path
      end
    end
    
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #show" do
    let(:admin) { create(:user, admin: true) }
    let(:product) { Admin::Product.create(attributes_for(:product, created_by: admin)) }
    context 'when user is an admin' do
      before do
        sign_in admin
        get :show, params: { id: product.id }
      end
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns @admin_product" do
        expect(assigns[:admin_product]).to eq(product)
      end

      it "render template" do
        expect(response).to render_template("show")
      end
    end
    context 'when user is not an admin' do
      let(:user) { create(:user, admin: false) }
      it "redirect_to root_path" do
        sign_in user
        get :show, params: {id: product.id}
        expect(response).to redirect_to root_path
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        get :show, params: {id: product.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #edit" do
    let(:admin) { create(:user, admin: true) }
    let(:product) { Admin::Product.create(attributes_for(:product, created_by: admin)) }
    context 'when user is an admin' do
      before do
        sign_in admin
        get :edit, params: { id: product.id }
      end
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns @admin_product" do
        expect(assigns[:admin_product]).to eq(product)
      end

      it "render template" do
        expect(response).to render_template("edit")
      end
    end
    context 'when user is not an admin' do
      let(:user) { create(:user, admin: false) }
      it "redirect_to root_path" do
        sign_in user
        get :edit, params: {id: product.id}
        expect(response).to redirect_to root_path
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        get :edit, params: {id: product.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    let(:admin) { create(:user, admin: true) }
    let(:product) { Admin::Product.create(attributes_for(:product, created_by: admin)) }
    context 'when user is an admin' do
      before do
        sign_in admin
      end
      it 'deletes the product' do
        product.reload
        expect do
          delete :destroy, params: { id: product.id }
        end.to change { Admin::Product.count }.by(-1)
      end
      it "only updates destroyed_at but real delete" do
        delete :destroy, params: { id: product.id }
        product.reload
        expect(product.destroyed_at).not_to be_nil
      end
      it "redirect_to admin_products_path" do
        delete :destroy, params: { id: product.id }
        expect(response).to redirect_to admin_products_path 
      end
    end
    context 'when user is not an admin' do
      let(:user) { create(:user, admin: false) }
      it "redirect_to root_path" do
        sign_in user
        delete :destroy, params: { id: product.id }
        expect(response).to redirect_to root_path
      end
    end
    context 'when user did not sign in' do
      it 'redirect_to new_user_session_path ' do 
        delete :destroy, params: { id: product.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
