class Hostel < ApplicationRecord
	has_many :rooms
	validates :name, presence: true, uniqueness: true
  validates :address, presence: true
end
