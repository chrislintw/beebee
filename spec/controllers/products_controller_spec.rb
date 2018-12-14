require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #index" do
    let(:admin) { create(:user, admin: true)}
    let(:product) { create(:product, created_by: admin)}
    before do
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "assigns @products" do
      expect(assigns[:products]).to eq([product])
    end
    it 'renders show template' do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    let(:admin) { create(:user, admin: true)}
    let(:product) { create(:product, created_by: admin)}
    before do
      get :show, params: {id: product.id}
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it 'assigns @product' do
      expect(assigns[:product]).to eq(product)
    end
    it 'renders show template' do
      expect(response).to render_template("show")
    end
  end

end
