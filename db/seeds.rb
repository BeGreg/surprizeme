# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "starting Amazon"

require 'capybara/poltergeist'

# Configure Poltergeist to not blow up on websites with js errors aka every website with js
# See more options at https://github.com/teampoltergeist/poltergeist#customization
Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false, :phantomjs => Phantomjs.path)
  end

  # Configure Capybara to use Poltergeist as the driver
  Capybara.default_driver = :poltergeist

selection = []

# browser = Capybara.current_session
# url = "https://www.leroymerlin.fr/v3/search/search.do?resultOffset=0&resultLimit=50&resultListShape=PLAIN&keyword=bois"
# browser.visit url
# products = browser.all '.prd-infos h3'

# products.each do |article|
#   puts article.find("a")[:href]
#   title_element = article.text
#   puts title_element
# end

browser = Capybara.current_session
# url = "https://www.amazon.fr/gadget-high-tech-High-Tech/s?ie=UTF8&page=1&rh=n%3A13921051%2Ck%3Agadget%20high%20tech"
# url pour test produit binding pry
url = "https://www.amazon.fr/Organiseur-Universe-Accessoires-Electroniques-Capacit%C3%A9/dp/B014ZJKX1W/ref=sr_1_2?s=electronics&ie=UTF8&qid=1512513598&sr=1-2&keywords=gadget+high+tech"

browser.visit url
binding.pry
products = browser.all '.s-item-container'



products.each do |article|
  if article.has_css?('.a-icon-star')
    note = article.all('.a-icon-star')[0].text[0]
    if note.to_i > 3
      puts name = article.find('.s-access-title').text
      puts note = article.all('.a-icon-star')[0].text[0]
      note = "#{note}.#{article.all('.a-icon-star')[0].text[2]}" if note.to_f == 4
      print note.to_f
      print nb_note = article.all("a").last.text
      # print article.all('.s-access-detail-page')[:url]
      print url = article.find('.s-access-detail-page')[:href]
      product = Product.new(name: name, supplier_review: note.to_f, supplier_review_number: nb_note, url: url, status:"créé", supplier_id:1)
      selection << product
    end
  end
end

selection.each do |product|
  browser.visit product.url
  product.description = browser.find_by_id('productDescription').text
  if browser.has_no_text?(:visible, "Nouveau Prix")
    price_text = browser.find_by_id('priceblock_ourprice').text
  else
    price_text = browser.find_by_id('priceblock_saleprice').text
  end
  product.price = price_text.last(5).gsub(",",".").to_f
  product.characteristic = browser.all('.techD')[0].text
  if browser.find_by_id('wayfinding-breadcrumbs_feature_div')
    product.supplier_category = browser.find_by_id('wayfinding-breadcrumbs_feature_div').all('li').last.text
  else
    product.supplier_category = "Gadget"
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
  product.save!
end

# A CONSERVER pour scrapper les autres images
# browser.all('script', visible: false)[3].text(:all)
# <script type="text/javascript">
# P.when('A').register("ImageBlockATF", function(A){
#     var data = {
#                 'colorImages': { 'initial': [
#                   {
#                     "hiRes":"https://images-na.ssl-images-amazon.com/images/I/61ytV%2BA1LUL._SL1001_.jpg",
#                     "thumb":"https://images-na.ssl-images-amazon.com/images/I/51JnDmJAh1L._SX38_SY50_CR,0,0,38,50_.jpg",
#                     "large":"https://images-na.ssl-images-amazon.com/images/I/51JnDmJAh1L.jpg",
#                     "main":{"https://images-na.ssl-images-amazon.com/images/I/61ytV%2BA1LUL._SX536_.jpg":[357,536],"https://images-na.ssl-images-amazon.com/images/I/61ytV%2BA1LUL._SX603_.jpg":[402,603],"https://images-na.ssl-images-amazon.com/images/I/61ytV%2BA1LUL._SX666_.jpg":[444,666],"https://images-na.ssl-images-amazon.com/images/I/61ytV%2BA1LUL._SX730_.jpg":[486,730],"https://images-na.ssl-images-amazon.com/images/I/61ytV%2BA1LUL._SX818_.jpg":[545,818]
#                     },
#                     "variant":"MAIN",
#                     "lowRes":null
#                   },
#                   {"hiRes":"https://images-na.ssl-images-amazon.com/images/I/61wc-P3EKqL._SL1001_.jpg","thumb":"https://images-na.ssl-images-amazon.com/images/I/51RUMZo32oL._SX38_SY50_CR,0,0,38,50_.jpg","large":"https://images-na.ssl-images-amazon.com/images/I/51RUMZo32oL.jpg","main":{"https://images-na.ssl-images-amazon.com/images/I/61wc-P3EKqL._SX536_.jpg":[357,536],"https://images-na.ssl-images-amazon.com/images/I/61wc-P3EKqL._SX603_.jpg":[402,603],"https://images-na.ssl-images-amazon.com/images/I/61wc-P3EKqL._SX666_.jpg":[444,666],"https://images-na.ssl-images-amazon.com/images/I/61wc-P3EKqL._SX730_.jpg":[486,730],"https://images-na.ssl-images-amazon.com/images/I/61wc-P3EKqL._SX818_.jpg":[545,818]},"variant":"PT01","lowRes":null},{"hiRes":"https://images-na.ssl-images-amazon.com/images/I/61M0x6HCs7L._SL1001_.jpg","thumb":"https://images-na.ssl-images-amazon.com/images/I/51d6DfG%2BkyL._SX38_SY50_CR,0,0,38,50_.jpg","large":"https://images-na.ssl-images-amazon.com/images/I/51d6DfG%2BkyL.jpg","main":{"https://images-na.ssl-images-amazon.com/images/I/61M0x6HCs7L._SX536_.jpg":[357,536],"https://images-na.ssl-images-amazon.com/images/I/61M0x6HCs7L._SX603_.jpg":[402,603],"https://images-na.ssl-images-amazon.com/images/I/61M0x6HCs7L._SX666_.jpg":[444,666],"https://images-na.ssl-images-amazon.com/images/I/61M0x6HCs7L._SX730_.jpg":[486,730],"https://images-na.ssl-images-amazon.com/images/I/61M0x6HCs7L._SX818_.jpg":[545,818]},"variant":"PT02","lowRes":null},{"hiRes":"https://images-na.ssl-images-amazon.com/images/I/61%2BGyxMWnmL._SL1001_.jpg","thumb":"https://images-na.ssl-images-amazon.com/images/I/51a-QoJvyPL._SX38_SY50_CR,0,0,38,50_.jpg","large":"https://images-na.ssl-images-amazon.com/images/I/51a-QoJvyPL.jpg","main":{"https://images-na.ssl-images-amazon.com/images/I/61%2BGyxMWnmL._SX536_.jpg":[357,536],"https://images-na.ssl-images-amazon.com/images/I/61%2BGyxMWnmL._SX603_.jpg":[402,603],"https://images-na.ssl-images-amazon.com/images/I/61%2BGyxMWnmL._SX666_.jpg":[444,666],"https://images-na.ssl-images-amazon.com/images/I/61%2BGyxMWnmL._SX730_.jpg":[486,730],"https://images-na.ssl-images-amazon.com/images/I/61%2BGyxMWnmL._SX818_.jpg":[545,818]},"variant":"PT03","lowRes":null},{"hiRes":"https://images-na.ssl-images-amazon.com/images/I/61ipg7dqp1L._SL1001_.jpg","thumb":"https://images-na.ssl-images-amazon.com/images/I/51t4s2NXdDL._SX38_SY50_CR,0,0,38,50_.jpg","large":"https://images-na.ssl-images-amazon.com/images/I/51t4s2NXdDL.jpg","main":{"https://images-na.ssl-images-amazon.com/images/I/61ipg7dqp1L._SX536_.jpg":[357,536],"https://images-na.ssl-images-amazon.com/images/I/61ipg7dqp1L._SX603_.jpg":[402,603],"https://images-na.ssl-images-amazon.com/images/I/61ipg7dqp1L._SX666_.jpg":[444,666],"https://images-na.ssl-images-amazon.com/images/I/61ipg7dqp1L._SX730_.jpg":[486,730],"https://images-na.ssl-images-amazon.com/images/I/61ipg7dqp1L._SX818_.jpg":[545,818]},"variant":"PT04","lowRes":null},{"hiRes":"https://images-na.ssl-images-amazon.com/images/I/61RcRhE1GaL._SL1001_.jpg","thumb":"https://images-na.ssl-images-amazon.com/images/I/51LUMYjQRuL._SX38_SY50_CR,0,0,38,50_.jpg","large":"https://images-na.ssl-images-amazon.com/images/I/51LUMYjQRuL.jpg","main":{"https://images-na.ssl-images-amazon.com/images/I/61RcRhE1GaL._SX536_.jpg":[357,536],"https://images-na.ssl-images-amazon.com/images/I/61RcRhE1GaL._SX603_.jpg":[402,603],"https://images-na.ssl-images-amazon.com/images/I/61RcRhE1GaL._SX666_.jpg":[444,666],"https://images-na.ssl-images-amazon.com/images/I/61RcRhE1GaL._SX730_.jpg":[486,730],"https://images-na.ssl-images-amazon.com/images/I/61RcRhE1GaL._SX818_.jpg":[545,818]},"variant":"PT05","lowRes":null},{"hiRes":"https://images-na.ssl-images-amazon.com/images/I/61ukJ7wP1LL._SL1001_.jpg","thumb":"https://images-na.ssl-images-amazon.com/images/I/51OecRuuoZL._SX38_SY50_CR,0,0,38,50_.jpg","large":"https://images-na.ssl-images-amazon.com/images/I/51OecRuuoZL.jpg","main":{"https://images-na.ssl-images-amazon.com/images/I/61ukJ7wP1LL._SX536_.jpg":[386,536],"https://images-na.ssl-images-amazon.com/images/I/61ukJ7wP1LL._SX603_.jpg":[434,603],"https://images-na.ssl-images-amazon.com/images/I/61ukJ7wP1LL._SX666_.jpg":[479,666],"https://images-na.ssl-images-amazon.com/images/I/61ukJ7wP1LL._SX730_.jpg":[525,730],"https://images-na.ssl-images-amazon.com/images/I/61ukJ7wP1LL._SX818_.jpg":[588,818]},"variant":"PT06","lowRes":null}]},
#                 'colorToAsin': {'initial': {}},
#                 'holderRatio': 0.84,
#                 'holderMaxHeight': 700,
#                 'heroImage': {'initial': []},
#                 'heroVideo': {'initial': []},
#                 'spin360ColorData': {'initial': {}},
#                 'spin360ColorEnabled': {'initial': 0},
#                 'spin360ConfigEnabled': false,
#                 'playVideoInImmersiveView':'false',
#                 'videoIngressExperimentTreatment':'C',
#                 'totalVideoCount':'0',
#                 'videoIngressATFSlateThumbURL':'',
#                 'weblabs' : {}
#                 };
#     A.trigger('P.AboveTheFold'); // trigger ATF event.
#     return data;
# });
# </script>

  # has_css?
  # unless article.all 'a-icon-alt'.nil?
  #   rating = "#{article.all('.a-icon-alt').text.strip.first}.#{element.search('.a-icon-alt').text.strip[2]}"
  #   if rating.to_i >= 4
  #     title = element.search('.s-access-title').text.strip
  #     puts title
  #     puts rating.to_is
  #   end
  # end
#     print title
#   url = element.search('a').first.attr('href')
#   selection << { name: title, url: url }
# end

# puts 'starting Nokogiri'

# selection = []
# url = "https://www.leroymerlin.fr/v3/search/search.do?resultOffset=0&resultLimit=50&resultListShape=PLAIN&keyword=bois"
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)
# html_doc.search('.prd-infos').search('h3').each do |element|
#   title = element.text.strip
#   print title
#   url = element.search('a').first.attr('href')
#   selection << { name: title, url: url }
# end
