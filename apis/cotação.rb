require 'net/http'
require 'json'
require 'uri'

uri = URI('http://api.promasters.net.br/cotacao/v1/valores')
http = Net::HTTP.new(uri.host, uri.port)
req = Net::HTTP::Get.new(uri.path)
res = http.request(req)
array = JSON.parse(res.body)

puts "Dólar = #{array["valores"]["USD"]["valor"]}"
puts "Euro = #{array["valores"]["EUR"]["valor"]}"
puts "Peso Argentino = #{array["valores"]["ARS"]["valor"]}"
puts "Libra Esterlina = #{array["valores"]["GBP"]["valor"]}"
puts "Bitcoin = #{array["valores"]["BTC"]["valor"]}"
