module Admin
  class ProductsController < BaseController
    before_action :set_product, only: %i[show edit update destroy]
    def index
      @admin_products = Product.all.page(params[:page]).with_attached_image
    end

    def show; end

    def new
      @admin_product = Product.new
    end

    def create
      @admin_product = Product.new(product_params)
      @admin_product.created_by = current_user
      if @admin_product.save
        redirect_to @admin_product, notice: '成功建立產品'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @admin_product.update(product_params)
        redirect_to @admin_product, notice: '成功更新產品'
      else
        render :edit
      end
    end

    def destroy
      if @admin_product.soft_destroy!
        redirect_to admin_products_path, notice: '成功刪除產品'
      else
        redirect_to @admin_product, alert: '此產品無法刪除'
      end
    end

    private

    def set_product
      @admin_product = Admin::Product.find(params[:id])
    end
    def product_params
      params.require(:admin_product).permit(:name, :price, :image, :discount)      
    end
  end
end
