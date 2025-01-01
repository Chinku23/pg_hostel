class Room < ApplicationRecord
  belongs_to :hostel
  has_many :bookings, dependent: :destroy
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
