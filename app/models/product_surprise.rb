class ProductSurprise < Surprise
  belongs_to :product
  validates :del_first_name, presence:true
  validates :del_last_name, presence:true
  validates :del_address, presence:true
end
