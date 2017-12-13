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
# url = "https://www.amazon.fr/s/ref=sr_st_review-rank?keywords=gadget+insolite&rh=n%3A13921051%2Ck%3Agadget+insolite&qid=1512384836&__mk_fr_FR=%C3%85M%C3%85Z%C3%95%C3%91&sort=review-rank"
# # url pour test produit binding pry
# # url = "https://www.lavantgardiste.com/salle-de-bains/3132-lumiere-de-bain-disco-5060243077875.html"

# browser.visit url
# products = browser.all '.s-item-container'

# BILLET REDUC START
puts 'Start BilletReduc'
driver = Selenium::WebDriver.for :firefox
# lien scrap de base
driver.get "http://www.billetreduc.com/a-lyon/liste/"
puts 'je suis sur le site'

# Pour scraper toutes les pages du lien de scrap au dessus
total_events = driver.find_element(:class, "headerInfo").text.scan(/\d+/).join("").to_i
# 30 produits par page, donc calcul du nb de pages
max = (total_events / 30.0).ceil
i = 0

while i < max do
  i+=1
  driver.get "http://www.billetreduc.com/a-lyon/liste/s.htm?gp=3&Lpg=#{i}"
  puts "je suis sur le site page #{i}"


  events = []

  # chaque lien de spectacle
  driver.find_elements(:class, 'leEvt').each do |event|
    events << event.find_element(:tag_name, "a")[:href]
  end

  # que faire avec chaque lien
  events.each do |link|
    driver.get link
    # aller sur la page du lieu du spectacle pour scraper les infos
    location_url = driver.find_element(:class, "fn")[:href]
    driver.get  location_url
    location_name = driver.find_element(:class, "bgbeige").text
    location_address = driver.find_element(:class, "bgbeige").text
    # créer location en premier, car les autres (moment, représentation) en dépendent
    location = Location.find_or_create_by(name: location_name, address: location_address)
  puts 'Location created'
    driver.get link
    name = driver.find_element(:class, "summary").text
    url = link
    description = "<p><strong>" + driver.find_element(:tag_name, "h6").text + "</strong></p><p>" + driver.find_element(:id, "speDescription").text + "</p>"

    # pour éviter erreur image
    begin
    photo_url1 = driver.find_element(:class, "photoevt")[:src]
    rescue Selenium::WebDriver::Error::NoSuchElementError
    false
    end

    location_id = location.id
    # créer un moment si pas trouvé dans la DB
    moment = Moment.find_or_create_by(url: url)
    moment.update(name: name ,
                  url: url,
                  description: description,
                  photo_url1: photo_url1,
                  location_id: location_id)
    puts 'Moment created'
    # éviter le bug du "il n'y a pas de dates & tarifs"
    begin
    driver.find_element(:link_text, "Dates & Tarifs").click

      driver.find_elements(:class, "calendrierhome").each do |cal_month|
      month = cal_month[:m].to_i
      year = cal_month[:y].to_i

      cal_month.find_elements(:class, "day").each do |cal_day|
        day = cal_day[:d].to_i

        cal_day.find_elements(:tag_name, "a").each do |show|

          prices = show[:title].scan(/\d+\W\d{2}/).each { |p| p.gsub!("€", ".")}
          time = show.text
            hour = time.split('h')[0].to_i
            minutes = time.split('h')[1].to_i
          date = DateTime.new(year, month, day, hour, minutes)

          delivery_price = 1.95


          representation = Representation.find_or_create_by(moment_id: moment.id, date: date)
          representation.update(price_collection: prices, del_price: delivery_price)
          puts 'Representation created'
        end
      end
    end
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    end
  end
end



# Scrap Amazon
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



# # Scrap Raffineurs
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
#     gender: "male"
#     )
# end


