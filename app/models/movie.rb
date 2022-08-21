class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :restrict_with_error
  # can’t delete a movie if it is referenced in at least one bookmark
  #-??Then why in correction there is no "dependent: :restrict_with_error"??

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
