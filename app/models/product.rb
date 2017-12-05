class Product < ApplicationRecord
  belongs_to :supplier
  has_many :surprises
  has_many :ratings
  validates :name, presence:true
  validates :url, presence:true, uniqueness:true
  validates :description, presence:true
  validates :price, presence:true
  validates :name, presence:true
  validates :supplier_review, presence:true
  validates :supplier_category, presence:true
  validates :status, presence:true, default:"Créé"
  validates :photo_url1, presence:true
  validates :delivery_price, prensence:true

end
