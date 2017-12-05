class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product, optional: true
  belongs_to :moment, optional: true
  validates :rating, presence:true
end
