require 'rails_helper'

RSpec.describe User, type: :model do
  # constant specs
  # associations specs
  it { should have_many(:products) }
  # validations specs
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(255) }
  # scope specs
  # class method specs
  # instance method specs
end
