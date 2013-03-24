class Info < ActiveRecord::Base

  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  has_many :comments, as: :commentable, dependent: :destroy

  attr_accessor :comment
  attr_accessible :content, :title, :important, :comment, :comments_attributes, :recipient_id
  accepts_nested_attributes_for :comments, allow_destroy: true, reject_if: proc { |attr| attr['content'].blank? }

  validates :title, :content, presence: true
  validates_associated :comments

  scope :newest, order('created_at desc')
  scope :oldest, order('created_at asc')
  scope :grouped_by_date
  scope :important, where(important: true)
  scope :available_for, lambda { |user| where(recipient_id: [user.id, nil]) }
  scope :addressed_to, lambda { |user| where(recipient_id: user.id) }
  scope :public, where(recipient_id: nil)

  def comment=(content)
    comments.build content: content unless content.blank?
  end

  def recipient_presentation
    recipient.present? ? recipient.short_name : ''
  end

  def type_s
    recipient_id.present? ? 'personal' : 'public'
  end

  private

  def grouped_by_date
    select("date(created_at) as info_date, count(title) as total_infos").group("infos.created_at::date)")
  end

end
