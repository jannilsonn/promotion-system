class Promotion < ApplicationRecord
    has_many :coupons
    validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: { message: 'não pode ficar em branco' }
    validates :name, :code, uniqueness: { message: 'deve ser único' }

    def generate_coupons!
        return if coupons?

        Coupon.transaction do
            (1..coupon_quantity).each do |number|
                coupons.create!(code: "#{self.code}-#{'%04d' % number}")
            end
        end
    end

    def coupons?
        coupons.any?
    end
end
