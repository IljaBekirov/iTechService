class SparePart < ApplicationRecord
  belongs_to :repair_service
  belongs_to :product
  has_many :store_items, through: :product
  delegate :name, :quantity_threshold, :comment, :quantity_in_store, :purchase_price, :remnant_s, :remnant_status,
           to: :product, allow_nil: true
  validates_presence_of :quantity, :product

  after_initialize do
    self.warranty_term ||= product.try(:warranty_term)
  end

end
