class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, foreign_key: :created_by_id
  validates :name, presence: true, length: { maximum: 255 }


  def upgrade!
    update(primium: true)
  end
  
end
