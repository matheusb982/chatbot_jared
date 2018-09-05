require "net/https"
require 'net/http'
require 'json'
require 'uri'

uri = URI.parse("http://apiadvisor.climatempo.com.br/api/v1/forecast/locale/8050/days/15?token=168afc973f520179b3196291c4a5e0d7")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

array_nodes = JSON.parse(response.body)
puts array_nodes["data"][0]["thermal_sensation"]
puts 'dia atual'
if array_nodes["data"][0]["phrase"]
  puts array_nodes["data"][0]["phrase"]["morning"]
  puts array_nodes["data"][0]["phrase"]["afternoon"]
  puts array_nodes["data"][0]["phrase"]["night"]
end

puts '-----'
# puts array_nodes["data"][1]
# puts '-----'
# puts array_nodes["data"][2]
# puts '-----'
# puts array_nodes["data"][3]
# puts '-----'
# puts array_nodes["data"][4]
