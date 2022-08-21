class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { minimum: 6 }
  has_one :list
  has_one :movie
  #A bookmark must be linked to a movie and a list
  #-Then why no "has_one" in correction?
  validates :movie_id, uniqueness: { scope: :list_id, message: "There can be only 1 unique movie--list for a bookmark, and this movie is already in a list" }
end
