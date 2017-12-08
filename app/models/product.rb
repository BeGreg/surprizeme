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
  validates :status, presence:true
  validates :photo_url1, presence:true
  validates :delivery_price, presence:true

def self.random(budget, gender, category)
    productList = []
    Product.all.each do |product|
      puts product.name
      puts product.budget_match?(budget)
      puts product.gender_match?(gender)
      puts product.category_match?(category)
      productList << product if product.budget_match?(budget)  && product.gender_match?(gender) && product.category_match?(category)
    end
    puts productList
    return productList.sample.id
  end

  def budget_match?(required_budget)
    #TODO : ajouter delivery price
    (price < required_budget.to_i) && (price > (required_budget.to_i * 0.75))
  end

  def gender_match?(required_gender)
    if required_gender = "indifferent"
      return true
    else
      return true
      # return required_gender == @product.gender
    end
  end

  def category_match?(required_category)
    # required_category == @product.supplier_category
    true
  end

end
