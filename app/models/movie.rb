class Movie < ApplicationRecord
  #belongs_to :user
  has_one_attached :image

  enum category: [:Drama, :Romance, :Action, :Comedy, :Fantasy, :Adventure]

  validates :title, presence: true, length: { in: 3..128 }
  validates :description, presence: true, length: { in: 5..300 }
  validates :category, inclusion: { in: Movie::categories }
end
