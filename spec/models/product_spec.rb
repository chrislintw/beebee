require 'rails_helper'

RSpec.describe Product, type: :model do
  # constant specs
  # associations specs
  it { should belong_to(:created_by) }
  # validations specs
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:price).is_less_than_or_equal_to(4294967295) }
  # scope specs
  # class method specs
  # instance method specs
end
