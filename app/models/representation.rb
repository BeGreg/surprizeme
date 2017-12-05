class Representation < ApplicationRecord
  belongs_to :moment
  validates :date, presence:true
  validates :price_collection, presence:true
  validates :del_price, presence:true
end
