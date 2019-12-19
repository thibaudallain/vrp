class Player < ApplicationRecord
  belongs_to :user
  has_many :selections
  has_many :conversions
  has_many :tries
  has_many :penalties
end
