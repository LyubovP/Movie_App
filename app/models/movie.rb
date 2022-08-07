class Movie < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  has_one_attached :image
  has_many :reviews

  enum category: [:Drama, :Romance, :Action, :Comedy, :Fantasy, :Adventure]

  validates :title, presence: true, length: { in: 3..128 }
  validates :description, presence: true, length: { in: 5..300 }
  validates :category, inclusion: { in: Movie::categories }

  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished, -> { where(published_at: nil) }

  friendly_id :title, use: %i[slugged history]

  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end
end
