require 'net/http'
require "net/https"
require 'json'
require 'uri'
require 'rss'
require 'open-uri'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :price
  before_action :news
  before_action :weather

  protected

  def weather
    uri = URI.parse("https://api.hgbrasil.com/weather/?format=json&woeid=455830")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)

    array_nodes = JSON.parse(response.body)

    @one_title = array_nodes["results"]["forecast"][0]["description"]

    @one   = array_nodes["results"]["forecast"][0]["max"]
    @two   = array_nodes["results"]["forecast"][1]["max"]
    @three = array_nodes["results"]["forecast"][2]["max"]
    @four  = array_nodes["results"]["forecast"][3]["max"]
    @five  = array_nodes["results"]["forecast"][4]["max"]
    @sex   = array_nodes["results"]["forecast"][5]["max"]

    @one_day = day_used(0)
    @two_day = day_used(1)
    @three_day = day_used(2)
    @four_day = day_used(3)
    @five_day = day_used(4)
    @sex_day = day_used(5)


  end

  def news
    url = 'http://pox.globo.com/rss/g1/tecnologia/'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)

      item = feed.items.first

      @title_news = item.title
      @date_news = item.pubDate

      one = item.description.partition('"')[2]
      two = one.partition('jpg')[2]
      three = one.chomp("#{two}")

      @image_news = three
    end

  end

  def price
    # uri = URI('http://api.promasters.net.br/cotacao/v1/valores')
    # http = Net::HTTP.new(uri.host, uri.port)
    # req = Net::HTTP::Get.new(uri.path)
    # res = http.request(req)
    # array = JSON.parse(res.body)
    #
    # @dolar = array["valores"]["USD"]["valor"]
    # @euro = array["valores"]["EUR"]["valor"]
    # @peso = array["valores"]["ARS"]["valor"]
    # @libra = array["valores"]["GBP"]["valor"]
    # @bitcoin = array["valores"]["BTC"]["valor"]
    @dolar = ''
    @euro = ''
    @peso = ''
    @libra = ''
    @bitcoin = ''
  end

  def day_used(quant)
    day = Date.today+quant
    return day.strftime("%a")
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :avatar])
  end
end
