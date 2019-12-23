require 'csv'


class Player < ApplicationRecord
  belongs_to :user
  has_many :selections
  has_many :conversions
  has_many :tries
  has_many :penalties
  validates :user_id, required: false

  def self.to_csv
    attributes = %w{promo first_name last_name}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
