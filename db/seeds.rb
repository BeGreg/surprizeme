
require 'open-uri'
require 'capybara/poltergeist'
require 'selenium-webdriver'

# puts "starting les raffineurs, sac et maroquinerie"

# url = "https://www.lesraffineurs.com/35-sacs-et-maroquinerie"
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)
# html_doc.search('.product-container').search('.product-name').each do |element|
#   title = element.text.strip
#   url = element.attr('href')
#   selection << { name: title, url: url }
#   p selection
# end

#   selection << { name: title, url: url }
#   p selection
# end

# puts "starting les raffineurs, gosier"
# puts 'starting Nokogiri'

# selection = []
# url = "https://www.lesraffineurs.com/19-du-gosier"
# html_file = open(url).read
# html_dol }
#   p selection
# end

# Config for selenium ###
# # Configure to not blow up on websites with js errors aka every website with js
Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, js_errors: false, cookies: true, phantomjs: Phantomjs.path)
  end

  # Configure Capybara to use Poltergeist as the driver
  Capybara.default_driver = :selenium




## Config for Poltergeist ###

# # Configure Poltergeist to not blow up on websites with js errors aka every website with js
# # See more options at https://github.com/teampoltergeist/poltergeist#customization
# Capybara.register_driver :poltergeist do |app|
#     Capybara::Poltergeist::Driver.new(app, js_errors: false, cookies: true, phantomjs: Phantomjs.path)
#   end

#   # Configure Capybara to use Poltergeist as the driver
#   Capybara.default_driver = :poltergeist


# selection = []

# products_url = []
# browser = Capybara.current_session
# url = "https://www.lavantgardiste.com/salle-de-bains/3132-lumiere-de-bain-disco-5060243077875.html"
# # url = "https://www.amazon.fr/s/ref=sr_st_review-rank?keywords=gadget+insolite&rh=n%3A13921051%2Ck%3Agadget+insolite&qid=1512384836&__mk_fr_FR=%C3%85M%C3%85Z%C3%95%C3%91&sort=review-rank"
# # # url pour test produit binding pry

# browser.visit url
# # products = browser.all '.s-item-container'



##### SCRAPPING RAFFINEURS WITH SELENIUM ######
driver = Selenium::WebDriver.for :firefox
driver.get "https://www.lesraffineurs.com/du-palais/827-coquetiers-les-barbus.html"
sleep(5)
driver.find_element(:id, 'add_to_cart').click
sleep(5)
driver.find_element(:class, 'button-medium').click
sleep(5)
driver.find_elements(:class, 'button-medium')[1].click
sleep(5)
driver.find_element(:id, 'email').send_keys("gregory.blain@gmail.com")
driver.find_element(:id, 'passwd').send_keys("#######")
driver.find_element(:id, 'SubmitLogin').click
sleep(5)
driver.find_elements(:tag_name, 'button')[2].submit
sleep(10)
driver.find_elements(:class, 'delivery_option_radio')[0].click

driver.find_element(:id, 'cgv').click
sleep(2)
driver.find_element(:class, 'standard-checkout').click
sleep(5)
driver.find_element(:class, 'be2bill_link').click
sleep(8)
driver.switch_to.frame 'be2bill_iframe'
sleep(2)
driver.find_element(:id, 'b2b-ccnum-input').send_keys("#######")
sleep(2)
driver.find_element(:id, 'b2b-month-input').send_keys("0#")
sleep(2)
driver.find_element(:id, 'b2b-year-input').send_keys("20##")
sleep(2)
driver.find_element(:id, 'b2b-cvv-input').send_keys("#######")
binding.pry
sleep(2.5) # wait for the js to create the popup in response to pressing the button
# driver.action.moveToElement(:id, 'b2b-submit')
driver.find_element(:id, 'b2b-submit').submit


###### SCRAPPING L'AVANGARDISTE WITH SELENIUM ######
# driver = Selenium::WebDriver.for :firefox
# driver.get "https://www.lavantgardiste.com/salle-de-bains/3132-lumiere-de-bain-disco-5060243077875.html"
# binding.pry
# sleep(5)
# driver.find_element(:id, 'add_to_cart').click
# sleep(5)
# driver.find_element(:class, 'button-medium').click
# sleep(5)
# driver.find_elements(:class, 'button-medium')[1].click
# sleep(5)
# driver.find_element(:id, 'email').send_keys("gregory.blain@gmail.com")
# driver.find_element(:id, 'passwd').send_keys("SurpriseMe")
# driver.find_element(:id, 'SubmitLogin').click
# sleep(5)
# driver.find_elements(:tag_name, 'button')[2].submit
# sleep(10)
# driver.find_elements(:class, 'delivery_option_radio')[0].click

# driver.find_element(:id, 'cgv').click
# sleep(2)
# driver.find_element(:class, 'standard-checkout').click
# sleep(5)
# driver.find_element(:class, 'be2bill_link').click
# sleep(8)
# driver.switch_to.frame '__privateStripeFrame3'
# sleep(2)
# driver.find_element(:id, 'b2b-ccnum-input').send_keys("######")
# sleep(2)
# driver.find_element(:id, 'b2b-month-input').send_keys("0#")
# sleep(2)
# driver.find_element(:id, 'b2b-year-input').send_keys("##")
# sleep(2)
# driver.find_element(:id, 'b2b-cvv-input').send_keys("####")
# sleep(2.5) # wait for the js to create the popup in response to pressing the button
# driver.find_element(:id, 'b2b-submit').submit


### Scrap Amazon ###
# puts "scrapping Amazon"
# products.each do |article|
#   if article.has_css?('.a-icon-star')
#     note = article.all('.a-icon-star')[0].text[0]
#     nb_note = article.all("a").last.text

#     if note.to_i > 3 || nb_note.to_i >= 5
#       puts name = article.find('.s-access-title').text
#       puts note = article.all('.a-icon-star')[0].text[0]
#       note = "#{note}.#{article.all('.a-icon-star')[0].text[2]}" if note.to_f == 4
#       print note.to_f
#       # print article.all('.s-access-detail-page')[:url]
#       print url = article.find('.s-access-detail-page')[:href]
#       product = Product.new(name: name, supplier_review: note.to_f, supplier_review_number: nb_note, url: url, supplier_id:1)
#       selection << product
#     end
#   end
#   product.photo_url1 = browser.find('.imgTagWrapper img', visible: :all)[:src]
#   product.save!
# end




### SCRAPBACK TEST (poltergeist) ###
# browser.find('#add-to-cart-button').click
# browser.all("input")[0].click
# browser.find("#nav-cart").click
# --------------------
# binding.pry
# browser.all('.exclusive')[1].click
# browser.visit "https://www.lavantgardiste.com/commande"
# browser.find('.standard-checkout').click
# browser.fill_in 'email', with: 'gregory.blain@gmail.com'
# browser.fill_in 'passwd', with: 'jE2Ob6k4'
# browser.find_by_id('SubmitLogin').click
# browser.has_checked_field?('addressesAreEquals')
# browser.uncheck('addressesAreEquals')
# browser.find('.button.button-small.btn.btn-default', visible: :all).click
# browser.find_by_id('addressesAreEquals').trigger('click')
# browser.find('a.btn', visible: :all).trigger('click')
# browser.fill_in 'company', with: 'Le Wagon'
# browser.fill_in 'address1', with: '23 rue Paul Montrochet'
# browser.fill_in 'postcode', with: '69002'
# browser.fill_in 'city', with: 'Lyon'
# browser.fill_in 'phone_mobile', with: '0607830808'
# browser.fill_in 'alias', with: 'Wagon'
# browser.find_by_id('submitAddress').click
# browser.select 'Wagon', from: 'id_address_delivery'
# browser.select 'Mon adresse', from: 'id_address_invoice'
# browser.find('.button.orange').trigger('click')
# browser.all("input")[0].trigger('click')
# browser.find('.button.orange').click
# # within_frame '__privateStripeFrame5' do { page.driver.browser.find_element(:id, 'cc-exp').send_keys '09' } end




# driver.find_elements(:class, "exclusive")[1].click
# driver.get "https://www.lavantgardiste.com/commande"
# driver.find_elements(:class, 'standard-checkout')[0].click
# driver.find_element(:id, 'email').send_keys("gregory.blain@gmail.com")
# driver.find_element(:id, 'passwd').send_keys("jE2Ob6k4")
# driver.find_element(:id, 'SubmitLogin').submit
# # driver.find_element(:id, 'SubmitLogin')[0].click
# # browser.has_checked_field?('addressesAreEquals')
# # browser.uncheck('addressesAreEquals')
# # browser.find('.button.button-small.btn.btn-default', visible: :all).click
# # browser.find_by_id('addressesAreEquals').trigger('click')
# # browser.find('a.btn', visible: :all).trigger('click')
# # browser.fill_in 'company', with: 'Le Wagon'
# # browser.fill_in 'address1', with: '23 rue Paul Montrochet'
# # browser.fill_in 'postcode', with: '69002'
# # browser.fill_in 'city', with: 'Lyon'
# # browser.fill_in 'phone_mobile', with: '0607830808'
# # browser.fill_in 'alias', with: 'Wagon'
# # browser.find_by_id('submitAddress').click
# # browser.select 'Wagon', from: 'id_address_delivery'
# # browser.select 'Mon adresse', from: 'id_address_invoice'
# driver.find_element(:tag_name, 'button').submit
# browser.all("input")[0].trigger('click')
# browser.find('.button.orange').click
# within_frame '__privateStripeFrame5' do page.driver.browser.find_element(:id, 'card_number').send_keys('4242')
# end

### Scrap Raffineurs ###
# puts 'startin les raffineurs, du palais, capybara'

# Supplier.create(name:"Les Raffineurs", url:"www.lesraffineurs.com")

# url = "https://www.lesraffineurs.com/18-du-palais"
# browser.visit url
# products = browser.all '.product-container'
# products.each do |product|
#   products_url << product.find('.product-name')[:href]
# end

# products_url.each do |url|
#   browser = Capybara.current_session
#   browser.visit url
#   name = browser.find('.pb-center-column').find('h1').text.strip
#   price = browser.find('.price').find('span').text.strip
#   description = browser.find('.pb-center-column').find_by_id('short_description_block').first('p').text.strip

#   #photo of the product
#   results = []
#   elems = browser.all(".zoomWindow", visible: :all)
#   elems.each do |elem|
#     style = elem['style']

#     match = style.scan( /background-image\: url\((.+)\)/).last
#     results << match.first
#   end
#   photo_one = results[0]

#   #If second photo exists, put in photo_two. Idem until photo_four
#   if !results[1].nil?
#     photo_two = results[1]
#   else
#     photo_two = nil
#   end

#   if !results[2].nil?
#     photo_three = results[2]
#   else
#     photo_three = nil
#   end

#   if !results[3].nil?
#     photo_four = results[3]
#   else
#     photo_four = nil
#   end

#   Product.create(
#     name: name,
#     url: url,
#     price: price.gsub('€', '').to_i,
#     description: description,
#     photo_url1: photo_one,
#     photo_url2: photo_two,
#     photo_url3: photo_three,
#     photo_url4: photo_four,
#     supplier_id: 1,
#     delivery_price: 6,
#     delivery_time: 3,
#     supplier_category: "Du Palais",
#     supplier_review: 0,
#     )
# end


