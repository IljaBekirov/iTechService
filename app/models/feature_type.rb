class FeatureType < ActiveRecord::Base

  KINDS = %w[imei serial_number other]

  default_scope ->{order('feature_types.kind asc')}
  scope :ordered, ->{order('feature_types.kind asc')}

  has_and_belongs_to_many :product_categories
  attr_accessible :name, :kind, :product_category_ids
  validates_presence_of :name, :kind
  validates_uniqueness_of :kind, unless: :is_other?
  validates_inclusion_of :kind, in: KINDS

  def is_imei?
    kind == 'imei'
  end

  def is_other?
    kind == 'other'
  end

  def self.imei
    FeatureType.find_or_create_by_kind kind: 'imei', name: 'IMEI'
    FeatureType.create_with(name: 'IMEI').find_or_create_by(kind: 'imei')
  end

  def self.serial_number
    FeatureType.create_with(name: 'Serial Number').find_or_create_by(kind: 'serial_number')
  end

end
