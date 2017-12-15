require 'selenium-webdriver'
# Config for selenium ###
# # Configure to not blow up on websites with js errors aka every website with js
Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, js_errors: false, cookies: true, phantomjs: Phantomjs.path)
  end

  # Configure Capybara to use Poltergeist as the driver
  Capybara.default_driver = :selenium

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
    # Product.where(supplier_id: 1, status: ["scrapped", "modified"]).each do |product|
    Product.all.each do |product|
      product_list << product if product.budget_match?(budget) && product.gender_match?(gender) && product.category_match?(category)
    end
    product_id = product_list.sample.id
    return product_id
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
      when "Les Raffineurs"
        scrap_raffineurs
      when "L'Avant-Gardiste"
        scrap_avant_gardiste
      when "Amazon"
        scrap_amazon
      else
    end
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

  private

  def scrap_raffineurs
    ##### SCRAPPING ACHAT RAFFINEURS WITH SELENIUM ######
    chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    chrome_opts = chrome_bin ? { "binary" => chrome_bin } : {}
    driver = Selenium::WebDriver.for(:chrome, options: chrome_opts)
    driver.get self.url
    sleep(15)
    # Ajout panier
    driver.find_element(:id, 'add_to_cart').click
    sleep(5)
    # Vue panier
    driver.find_element(:class, 'button-medium').click
    sleep(5)
    # Validation panier
    driver.find_elements(:class, 'button-medium')[1].click
    sleep(5)
    # Identification
    driver.find_element(:id, 'email').send_keys("gregory.blain@gmail.com")
    driver.find_element(:id, 'passwd').send_keys("#####")
    driver.find_element(:id, 'SubmitLogin').click
    sleep(5)
    # Validation adresse
    driver.find_elements(:tag_name, 'button')[2].submit
    sleep(5)
    # Choix mode de livraison + validation cgv
    driver.find_elements(:class, 'delivery_option_radio')[0].click
    driver.find_element(:id, 'cgv').click
    sleep(1)
    driver.find_element(:class, 'standard-checkout').click
    sleep(5)
    # Choix mode de paiement
    driver.find_element(:class, 'be2bill_link').click
    sleep(8)
    # Paiement
    driver.switch_to.frame 'be2bill_iframe'
    sleep(2)
    driver.find_element(:id, 'b2b-ccnum-input').send_keys("###")
    driver.find_element(:id, 'b2b-month-input').send_keys("###")
    driver.find_element(:id, 'b2b-year-input').send_keys("###")
    driver.find_element(:id, 'b2b-cvv-input').send_keys("###")
    sleep(1)
    driver.find_element(:id, 'b2b-submit').click
  end

  def scrap_avant_gardiste
    #### SCRAPPING ACHAT L'AVANGARDISTE WITH SELENIUM ######
    chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    chrome_opts = chrome_bin ? { "binary" => chrome_bin } : {}
    driver = Selenium::WebDriver.for(:chrome, options: chrome_opts)
    driver.get self.url
    # Ajout panier
    sleep(15)
    driver.find_elements(:class, 'exclusive')[1].click
    sleep(1)
    # Affichage panier
    driver.find_element(:class, 'shopping_cart').click
    sleep(5)
    # Validation panier
    driver.find_element(:class, 'standard-checkout').click
    sleep(5)
    # Identification
    driver.find_element(:id, 'email').send_keys("gregory.blain@gmail.com")
    driver.find_element(:id, 'passwd').send_keys("#####")
    driver.find_element(:id, 'SubmitLogin').click
    sleep(3)
    # Validation adresse livraison
    driver.find_elements(:tag_name, 'button')[0].click
    sleep(3)
    # Choix mode livraison
    driver.find_elements(:class, 'delivery_option_radio')[0].click
    driver.find_elements(:tag_name, 'button')[0].click
    # Paiement via Stripe
    driver.switch_to.frame(driver.find_element(css: 'iframe[name="__privateStripeFrame3"]'))
    driver.find_element(css: 'input[name="cardnumber"]').send_keys('####')
    driver.switch_to.default_content
    driver.switch_to.frame(driver.find_element(css: 'iframe[name="__privateStripeFrame5"]'))
    driver.find_element(css: 'input[name="exp-date"]').send_keys('##/##')
    driver.switch_to.default_content
    driver.switch_to.frame(driver.find_element(css: 'iframe[name="__privateStripeFrame4"]'))
    driver.find_element(css: 'input[name="cvc"]').send_keys('###')
    driver.switch_to.default_content
    driver.find_element(:class, 'stripe-submit-button').click
  end

  def scrap_amazon
    #### SCRAPPING ACHAT AMAZON WITH SELENIUM ######
    chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    chrome_opts = chrome_bin ? { "binary" => chrome_bin } : {}
    driver = Selenium::WebDriver.for(:chrome, options: chrome_opts)
    driver.get self.url
    sleep(10)
    driver.find_element(:id, 'add-to-cart-button').click
    sleep(2)
    driver.find_element(:id, 'hlb-ptc-btn-native').click
    sleep(2)
    driver.find_element(:id, 'ap_email').send_keys('gregory.blain@gmail.com')
    driver.find_element(:id, 'ap_password').send_keys('#####!')
    driver.find_element(:id, 'signInSubmit').submit
    sleep(5)
    # driver.find_element(:class, 'change-address-popover-link').click
    # sleep(5)
    # driver.find_element(:id, 'spc-popover-add-new-address-link').find_element(:tag_name, 'a').click
    # sleep(5)
    driver.find_element(:id, 'enterAddressFullName').send_keys('Le Wagon Gregory Blain ')
    driver.find_element(:id, 'enterAddressAddressLine1').send_keys('24 rue Paul Montrochet')
    sleep(1)
    driver.find_element(:id, 'enterAddressCity').send_keys('Lyon')
    driver.find_element(:id, 'enterAddressPostalCode').send_keys('69002')
    sleep(1)
    driver.find_element(:id, 'enterAddressPhoneNumber').send_keys('0601020304')
    driver.find_element(:class, 'submit-button-with-name').click

    sleep(5)
    driver.find_element(:class, 'a-button-text').click
    # driver.find_elements(:class, 'checkout-continue-link')[0].click
    sleep(5)
    driver.find_element(:id, 'pm_1').click
    sleep(3)

    driver.find_element(:class, 'payment-selected').find_element(:id, 'addCreditCardNumber').send_keys('######')
    driver.find_element(:class, 'payment-selected').find_element(:id, 'addCreditCardVerificationNumber').send_keys('#####')
    driver.find_element(:class, 'payment-selected').find_element(:id, 'confirm-card').click

    sleep(5)
    driver.find_element(:id, 'continue-top').submit
    sleep(5)
    driver.find_element(:class, 'place-your-order-button').click
  end
end
