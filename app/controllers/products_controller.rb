# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(16).with_attached_image
    @products = @products.where('name LIKE ?', "%#{params[:q]}%") if params[:q]
  end

  def show
    @product = Product.find(params[:id])
  end
end
