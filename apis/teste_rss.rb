require 'rss'
require 'open-uri'

url = 'http://pox.globo.com/rss/g1/tecnologia/'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)

  item = feed.items.first

  # puts item
  # puts '-----'
  # puts item.title
  # puts item.pubDate
  one = item.description.partition('"')[2]
  two = one.partition('jpg')[2]

  three = one.chomp("#{two}")

  puts three
end
