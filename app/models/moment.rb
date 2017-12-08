class Moment < ApplicationRecord
  belongs_to :location
  has_many :surprises
  has_many :ratings
  has_many :representations
  validates :name, presence:true
  validates :url, presence:true, uniqueness:true
  validates :description, presence:true
  validates :status, presence:true
  validates :photo_url1, presence:true
end
