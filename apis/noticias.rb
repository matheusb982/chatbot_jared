require "net/https"
require 'net/http'
require 'json'
require 'uri'

uri = URI.parse("https://api.rss2json.com/v1/api.json?rss_url=http%3A%2F%2Fpox.globo.com%2Frss%2Fg1%2Ftecnologia%2F")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

array_nodes = JSON.parse(response.body)

puts array_nodes["items"][0]["pubDate"]
puts array_nodes["items"][0]["title"]
puts array_nodes["items"][0]["link"]
