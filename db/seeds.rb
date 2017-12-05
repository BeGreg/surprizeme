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
url = "https://www.amazon.fr/gadget-high-tech-High-Tech/s?ie=UTF8&page=1&rh=n%3A13921051%2Ck%3Agadget%20high%20tech"
browser.visit url
products = browser.all '.s-item-container'

products.each do |article|
  binding.pry
  if article.has_css?('.a-icon-star')
    note = article.all('.a-icon-star')[0].text[0]
    if note.to_i > 3
      puts article.find('.s-access-title').text
      puts note = article.all('.a-icon-star')[0].text[0]
      note = "#{note}.#{article.all('.a-icon-star')[0].text[2]}" if note.to_f == 4
      print note.to_f
      print nb_note = article.all("a").last.text
      print article.all('.s-access-detail-page')[:url]
      print url = article.find('.s-access-detail-page')[:href]
    end
  end
end


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
