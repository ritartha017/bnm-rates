# frozen_string_literal: true

require_relative "bnm_rates/version"

require "nokogiri"
require "rest-client"
require "money"

Money.locale_backend = :currency

class BnmRates
  attr_reader :date, :response

  def initialize(options = {})
    date = options[:date] ||= Time.now.strftime("%d.%m.%Y")
    lang = options[:lang] ||= :en
    uri = "https://www.bnm.md/#{lang}/official_exchange_rates?get_xml=1&date=#{date}"
    response = Nokogiri::XML((RestClient.get uri).body)

    @date = response.css("ValCurs")[0].get_attribute "Date"
    @response = parse(response)
  end

  def char_codes
    @response.keys
  end

  def exchange(money, currency_to)
    puts currency_from = money.currency.iso_code.to_sym

    money.with_currency(currency_to) *
      @response[currency_from][:rate] / @response[currency_to][:rate]
  end

  def pp_rates
    puts "Id|Symb|Rate|Name"
    @response.each_pair do |valute, value|
      puts "#{value[:id]}|#{valute}|#{value[:rate].truncate(4)}|#{value[:name]}"
    end
  end

  def parse(xml_doc)
    rates = {}
    xml_doc.css("Valute").map do |node|
      nominal = node.css("Nominal").text.to_i
      value = node.css("Value").text.to_f

      valute =
        {
          id: node.get_attribute("ID").to_i,
          num_code: node.css("NumCode").text,
          char_code: node.css("CharCode").text,
          nominal: nominal,
          name: node.css("Name").text,
          value: value,
          rate: value / nominal.to_f
        }
      rates[valute[:char_code].to_sym] = valute
      rates[:MDL] = { char_code: "MDL", name: "Moldovian Leu", value: 1, rate: 1 }
    end
    rates
  end

  def method_missing(name, *args, &block)
    if @response[name.to_sym].nil? == false
      @response[name.to_sym]
    else
      super
    end
  end

  # Return true or false if method @name exists.
  def respond_to_missing?(name, *args)
    !@response[name.to_sym].nil? || super
  end
end
