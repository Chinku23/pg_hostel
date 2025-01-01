class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: { in: ['pending', 'approved', 'rejected', 'canceled'] }

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    if end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
