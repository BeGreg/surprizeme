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
  # validates :delivery_price, presence:true
  enum status: [ :scrapped, :modified, :unsurprising, :archived ]
  monetize :price_cents

def self.random(budget, gender, category)
    product_list = []
    Product.where(status: ["scrapped", "modified"]).each do |product|
      product_list << product if product.budget_match?(budget) && product.gender_match?(gender) && product.category_match?(category)
    end
    puts product_list
    return product_list.sample.id
  end

  def budget_match?(required_budget)
    #TODO : ajouter delivery price
    (price.to_i <= required_budget.to_i) && (price.to_i >= (required_budget.to_i * 0.75))
  end

  def gender_match?(required_gender)
      return true
      # return required_gender == @product.gender
  end

  def category_match?(required_category)
    # required_category == @product.supplier_category
    true
  end

  def check_status
    # couting the ratings and defining a score
    surprising_rating = Rating.where(product_id: id, rating:true)
    unsurprising_rating = Rating.where(product_id: id, rating:false)
    nb_ratings = surprising_rating.count + unsurprising_rating.count
    score = surprising_rating.count / nb_ratings
    # setting a "dealbreaker" status if the score is too low
    status = "unsurprising" if (score < 0.25 && nb_ratings >= 10) || (score < 0.5 && nb_ratings >= 15)
  end

  def scrap
    surprise_supplier = self.supplier.name
    case surprise_supplier
      when "Amazon"
        scrap_amazon
      when "L'Avant-Gardiste"
        scrap_avant_gardiste
      else
    end
  end

  def scrap_amazon

end
