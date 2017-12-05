class Location < ApplicationRecord
  has_many :moments
  validates :name, presence:true
  validates :address, presence:true
end
