class Surprise < ApplicationRecord
  belongs_to :user
  validates :total_price, presence:true
  validates :name, presence:true
  validates :bill_first_name, presence:true
  validates :bill_last_name, presence:true
  validates :bill_address, presence:true
  validates :status, presence:true
end
