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

####### SCRAPPING PRODUCTS FROM AMAZON ############
browser = Capybara.current_session
url = "https://www.amazon.fr/s/ref=sr_st_review-rank?keywords=gadget+high+tech&rh=n%3A13921051%2Ck%3Agadget+high+tech&qid=1513164051&__mk_fr_FR=%C3%85M%C3%85Z%C3%95%C3%91&sort=review-rank"
browser.visit url
products = browser.all '.s-item-container'
puts "starting l'itération"
products.each do |article|
# binding.pry
  if article.has_css?('.a-icon-star')
    note = article.all('.a-icon-star')[0].text[0]
    print nb_note = article.all("a").last.text
    if (note.to_i > 3) && nb_note.to_i
      puts name = article.find('.s-access-title').text
      puts note = article.all('.a-icon-star')[0].text[0]
      note = "#{note}.#{article.all('.a-icon-star')[0].text[2]}" if note.to_f == 4
      print note.to_f
      # print article.all('.s-access-detail-page')[:url]
      print url = article.find('.s-access-detail-page')[:href]
      product = Product.new(
        name: name,
        supplier_review: (note.to_f * 10),
        supplier_review_number: nb_note,
        url: url,
        status:"scrapped",
        supplier_id:Supplier.where(name:"Amazon")[0].id)
      selection << product
    end
  end
end

selection.each do |product|
  puts "on débute le zoom produit"
  browser.visit product.url
  # binding.pry
  product.description = browser.find_by_id('productDescription')['outerHTML']
  if browser.has_no_text?(:visible, "Nouveau Prix")
    price_text = browser.find_by_id('priceblock_ourprice').text
  else
    price_text = browser.find_by_id('priceblock_saleprice').text
  end
  product.price = price_text.last(5).gsub(",",".").to_f
  product.characteristic = browser.all('.techD')[0].text
  if browser.has_css?('a-breadcrumb')
    product.supplier_category = browser.find_by_id('wayfinding-breadcrumbs_feature_div').all('li').last.text
  else
    product.supplier_category = "Sport"
  end
  browser.all('.imageThumbnail').each do |element|
    element.trigger('mousemove')
  end
    product.photo_url1 = browser.find_by_id('imgTagWrapperId').find('img', visible: :all)['src']
  if browser.has_css?('.itemNo2')
    product.photo_url1 = browser.find('.itemNo2', visible: :all).find('img', visible: :all)['src']
  end
  if browser.has_css?('.itemNo3')
    product.photo_url1 = browser.find('.itemNo3', visible: :all).find('img', visible: :all)['src']
  end
  if browser.has_css?('.itemNo4')
    product.photo_url1 = browser.find('.itemNo4', visible: :all).find('img', visible: :all)['src']
  end
    product.save!
end
