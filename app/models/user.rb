class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, :jwt_revocation_strategy => Devise::JWT::RevocationStrategies::Null

  enum role: { resident: 'resident', admin: 'admin' }
  has_many :bookings

  validates :role, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, format: { with: /\A(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}\z/, message: 'must include at least one uppercase letter and one digit' }, if: :password_required?
  
  def admin?
    role == 'admin'
  end
end

