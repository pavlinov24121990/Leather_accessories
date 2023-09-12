class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :surname, presence: true, length: { minimum: 2, maximum: 20 }

  enum role: %i[user admin]

  has_one_attached :avatar

  has_one :cart
  has_many :orders, dependent: :destroy

  def full_name
    "#{name} #{surname}"
  end

end
