class Promotion < ApplicationRecord
    has_many :coupons
    validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: { message: 'não pode ficar em branco' }
    validates :name, :code, uniqueness: { message: 'deve ser único' }
end
