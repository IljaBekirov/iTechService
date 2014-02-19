class SparePart < ActiveRecord::Base
  belongs_to :repair_service
  belongs_to :product
  has_many :store_items, through: :product
  delegate :name, :quantity_threshold, :comment, :quantity_in_store, :purchase_price, :remnant_s, to: :product, allow_nil: true
  attr_accessible :quantity, :warranty_term, :repair_service_id, :product_id
  validates_presence_of :quantity, :product

  after_initialize do
    self.warranty_term ||= product.try(:warranty_term)
  end

end
