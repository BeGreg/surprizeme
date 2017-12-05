class Supplier < ApplicationRecord
  has_many :suppliers
  validates :name, presence:true
  validates :url, presence:true
end
