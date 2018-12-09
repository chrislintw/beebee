class Product < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  validates :name, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4_294_967_295 }

end
