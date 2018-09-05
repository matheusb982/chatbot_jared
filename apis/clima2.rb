require "net/https"
require 'net/http'
require 'json'
require 'uri'

uri = URI.parse("https://api.hgbrasil.com/weather/?format=json&woeid=455830")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

array_nodes = JSON.parse(response.body)

puts 'Home'
puts array_nodes["results"]["forecast"][0]["description"]
puts array_nodes["results"]["forecast"][0]["max"]
puts '---'

puts array_nodes["results"]["forecast"][0]["max"]
puts array_nodes["results"]["forecast"][1]["max"]
puts array_nodes["results"]["forecast"][2]["max"]
puts array_nodes["results"]["forecast"][3]["max"]
puts array_nodes["results"]["forecast"][4]["max"]
puts array_nodes["results"]["forecast"][5]["max"]
