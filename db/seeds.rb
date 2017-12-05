# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "starting Amazon"

selection = []

browser = Capybara.current_session
url = "https://www.amazon.fr/s/ref=sr_st_review-rank?keywords=gadget+insolite&rh=n%3A13921051%2Ck%3Agadget+insolite&qid=1512384836&__mk_fr_FR=%C3%85M%C3%85Z%C3%95%C3%91&sort=review-rank"
browser.visit url

products = browser.all 's-item-container'

products.each do |article|
    puts article.all 'a-icon-alt'

  # has_css?
  # unless article.all 'a-icon-alt'.nil?
  #   rating = "#{article.all('.a-icon-alt').text.strip.first}.#{element.search('.a-icon-alt').text.strip[2]}"
  #   if rating.to_i >= 4
  #     title = element.search('.s-access-title').text.strip
  #     puts title
  #     puts rating.to_is
  #   end
  # end
end
#     print title
#   url = element.search('a').first.attr('href')
#   selection << { name: title, url: url }
# end
