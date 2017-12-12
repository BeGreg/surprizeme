class Surprise < ApplicationRecord
  belongs_to :user
  belongs_to :product, optional: true
  belongs_to :moment, optional: true
  validates :del_first_name, presence:true
  validates :del_last_name, presence:true
  validates :del_address, presence:true
  monetize :amount_cents
end
