class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product, optional: true
  belongs_to :moment, optional: true
  validates_inclusion_of :rating, :in => [true, false]
end
