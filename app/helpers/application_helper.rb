module ApplicationHelper
  def display_price(product)
    if user_signed_in? && (current_user.primium || current_user.admin) && product.discount
      price = product.price.to_i - product.discount
      content_tag(:del, "#{product.price} ") + content_tag(:span, price)
    else
      content_tag(:span, product.price)
    end
  end
end
