class Match < ApplicationRecord
  belongs_to :season
  has_many :selections
  has_many :tries
  has_many :penalties
  has_many :conversions
  has_many :players, through: :selections
end
