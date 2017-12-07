class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :surprises
  has_many :ratings
  has_many :products, through: :surprises
  has_many :moments, through: :surprises
  has_many :representations, through: :moments
  validates :first_name, presence:true
  validates :last_name, presence:true
  validates :email, presence:true, uniqueness:true
  validates :rater, presence:true
  validates :admin, presence:true
end
