# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
# puts "starting les raffineurs, sac et maroquinerie"
# puts 'starting Nokogiri'

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

# Require the gems
require 'capybara/poltergeist'

# Configure Poltergeist to not blow up on websites with js errors aka every website with js
# See more options at https://github.com/teampoltergeist/poltergeist#customization
Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false, cookies: true, phantomjs: Phantomjs.path)
  end

  # Configure Capybara to use Poltergeist as the driver
  Capybara.default_driver = :poltergeist


selection = []

products_url = []
browser = Capybara.current_session
url = "https://www.amazon.fr/s/ref=sr_st_review-rank?keywords=gadget+insolite&rh=n%3A13921051%2Ck%3Agadget+insolite&qid=1512384836&__mk_fr_FR=%C3%85M%C3%85Z%C3%95%C3%91&sort=review-rank"
# url pour test produit binding pry
# url = "https://www.lavantgardiste.com/salle-de-bains/3132-lumiere-de-bain-disco-5060243077875.html"

browser.visit url
products = browser.all '.s-item-container'


# Scrap Amazon
puts "scrapping Amazon"
products.each do |article|
  if article.has_css?('.a-icon-star')
    note = article.all('.a-icon-star')[0].text[0]
    nb_note = article.all("a").last.text

    if note.to_i > 3 || nb_note.to_i >= 5
      puts name = article.find('.s-access-title').text
      puts note = article.all('.a-icon-star')[0].text[0]
      note = "#{note}.#{article.all('.a-icon-star')[0].text[2]}" if note.to_f == 4
      print note.to_f
      # print article.all('.s-access-detail-page')[:url]
      print url = article.find('.s-access-detail-page')[:href]
      product = Product.new(name: name, supplier_review: note.to_f, supplier_review_number: nb_note, url: url, status:"créé", supplier_id:1)
      selection << product
    end
  end
   script = browser.all('script', visible: false)[3].text(:all)
  script.each do
    images = browser.find_by_id('landingImage')['data-a-dynamic-image'.to_sym]
    hash_images = (eval images).to_a
    nb_photos = hash_images.size
    product.photo_url1 = hash_images.first[0]
    product.photo_url2 = hash_images[1][0] if nb_photos >= 2
    product.photo_url3 = hash_images[2][0] if nb_photos >= 3
    product.photo_url4 = hash_images[3][0] if nb_photos >= 4
  end
  product.save!
end



# SCRAPBACK TEST
# browser.find('#add-to-cart-button').click
# browser.all("input")[0].click
# browser.find("#nav-cart").click
# --------------------
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
# browser.find('.button.orange').click
# browser.find_by_id('delivery_option_169482_0').trigger('click')
# browser.find('.button.orange').click



# Scrap Raffineurs
puts 'startin les raffineurs, du palais, capybara'
url = "https://www.lesraffineurs.com/18-du-palais"
browser.visit url
products = browser.all '.product-container'
products.each do |product|
  products_url << product.find('.product-name')[:href]
end

products_url.each do |url|
  browser = Capybara.current_session
  browser.visit url
  name = browser.find('.pb-center-column').find('h1').text.strip
  price = browser.find('.price').find('span').text.strip
  description = browser.find('.pb-center-column').find_by_id('short_description_block').first('p').text.strip

  #photo of the product
  results = []
  elems = browser.all(".zoomWindow", visible: :all)
  elems.each do |elem|
    style = elem['style']

    match = style.scan( /background-image\: url\((.+)\)/).last
    results << match.first
  end
  photo_one = results[0]

  #If second photo exists, put in photo_two. Idem until photo_four
  if !results[1].nil?
    photo_two = results[1]
  else
    photo_two = nil
  end

  if !results[2].nil?
    photo_three = results[2]
  else
    photo_three = nil
  end

  if !results[3].nil?
    photo_four = results[3]
  else
    photo_four = nil
  end

  Product.create(
    name: name,
    url: url,
    price: price.gsub('€', '').to_i,
    description: description,
    photo_url1: photo_one,
    photo_url2: photo_two,
    photo_url3: photo_three,
    photo_url4: photo_four,
    supplier_id: 1,
    delivery_price: 6,
    delivery_time: 3,
    supplier_category: "Du Palais",
    supplier_review: 0,
    status: "Créé"
    )
end


