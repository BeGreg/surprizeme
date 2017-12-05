# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "starting Amazon"


puts 'starting Nokogiri'

selection = []
url = "https://www.leroymerlin.fr/v3/search/search.do?resultOffset=0&resultLimit=50&resultListShape=PLAIN&keyword=bois"
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
html_doc.search('.prd-infos').search('h3').each do |element|
  title = element.text.strip
  print title
  url = element.search('a').first.attr('href')
  selection << { name: title, url: url }
end

# url = "https://www.amazon.fr/s/ref=sr_st_review-rank?keywords=gadget+insolite"
# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)
# html_doc.search('.s-item-container').each do |element|
#   unless element.search('.a-icon-alt').nil?
#     rating = "#{element.search('.a-icon-alt').text.strip.first}.#{element.search('.a-icon-alt').text.strip[2]}"
#     if rating.to_i >= 4
#       title = element.search('.s-access-title').text.strip
#       puts title
#       puts rating.to_is
#     else
#     end
#   end
# end
#     print title
#   url = element.search('a').first.attr('href')
#   selection << { name: title, url: url }
# end
