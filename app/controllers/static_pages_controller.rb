# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index
    @products = Product.top30.with_attached_image
  end
end
