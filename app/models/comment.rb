class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, -> { order(created_at: :asc) }, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  before_validation :normalize_parent_depth

  validates :author_name, presence: true, length: { maximum: 60 }
  validates :body, presence: true, length: { maximum: 2000 }
  validate :parent_must_belong_to_same_post

  scope :top_level, -> { where(parent_id: nil).order(created_at: :asc) }

  private

  # Enforce 1-level nesting: if replying to a reply, attach to the root comment
  def normalize_parent_depth
    self.parent_id = parent.parent_id if parent.present? && parent.parent_id.present?
  end

  def parent_must_belong_to_same_post
    return if parent.nil? || parent.post_id == post_id

    errors.add(:parent, 'must belong to the same post')
  end
end
