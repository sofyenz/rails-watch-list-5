class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  #When delete list, do NOT delete movies as they can be referenced in other lists
  #-??Then, why in correction, dependent: :destroy on has_many :movies??

  validates :name, presence: true, uniqueness: true
end
