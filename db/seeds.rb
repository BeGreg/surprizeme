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

# selection = []
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
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

# Configure Capybara to use Poltergeist as the driver
Capybara.default_driver = :poltergeist


puts 'startin les raffineurs, du palais, capybara'

products_url = []
browser = Capybara.current_session
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


