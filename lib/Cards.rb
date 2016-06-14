require_relative 'util'

class Cards

  # noinspection ALL
  class Card

    attr_reader :fingerprint, :expired, :type, :deleted, :exp_month, :number, :exp_year, :name, :token, :brand, :isin, :reference, :nickname, :issuer

    def initialize(options = {})
      @name = get_arg(options, 'name_on_card')
      @exp_year = get_arg(options, 'card_exp_year')
      @reference = get_arg(options, 'card_reference')
      @exp_month = get_arg(options, 'card_exp_month')
      @expired = get_arg(options, 'expired')
      @fingerprint = get_arg(options, 'card_fingerprint')
      @isin = get_arg(options, 'card_isin')
      @type = get_arg(options, 'card_type')
      @issuer = get_arg(options, 'card_issuer')
      @brand = get_arg(options, 'card_brand')
      @token = get_arg(options, 'card_token')
      @nickname = get_arg(options, 'nickname')
      @number = get_arg(options, 'card_number')
      @deleted = get_arg(options, 'deleted')
    end

  end

  def Cards.add(options={})
    method = 'POST'
    url = '/card/add'
    parameters = {}
    required_args = {}
    Array[:merchant_id, :customer_id, :customer_email, :card_number, :card_exp_year, :card_exp_month].each do |key|
      required_args.store(key,'False')
    end
    options.each do |key, value|
      parameters.store(key,value)
      required_args[key] = 'True'
    end
    Array[:merchant_id, :customer_id, :customer_email, :card_number, :card_exp_year, :card_exp_month].each do |key|
      if required_args[key] == 'False'
        raise "ERROR: #{key} is a required argument for Cards.add"
      end
    end
    parameters.each do |key, _|
      unless Array[:merchant_id, :customer_id, :customer_email, :card_number, :card_exp_year,
                   :card_exp_month, :name_on_card, :nickname].include?(key)
        puts " #{key} is an invalid argument for Cards.add"
      end
    end
    response = request(method,url,options)
    card = Card.new(response.body)
    return card
  end

  def Cards.list(options={})
    method = 'GET'
    url = '/card/list'
    parameters = {}
    required_args = {}
    Array[:customer_id].each do |key|
      required_args.store(key,'False')
    end
    options.each do |key, value|
      parameters.store(key,value)
      required_args[key] = 'True'
    end
    Array[:customer_id].each do |key|
      if required_args[key] == 'False'
        raise "ERROR: #{key} is a required argument for Cards.list"
      end
    end
    parameters.each do |key, _|
      unless Array[:customer_id].include?(key)
        puts " #{key} is an invalid argument for Cards.list"
      end
    end
    response = Array(request(method,url,options).body['cards'])
    cards = []
    i=0
    while i != response.count
      card = Card.new(response[i])
      cards.push(card)
      i+=1
    end
    return cards
  end

  def Cards.delete(options={})
    method = 'POST'
    url = '/card/delete'
    parameters = {}
    required_args = {}
    Array[:card_token].each do |key|
      required_args.store(key,'False')
    end
    options.each do |key, value|
      parameters.store(key,value)
      required_args[key] = 'True'
    end
    Array[:card_token].each do |key|
      if required_args[key] == 'False'
        raise "ERROR: #{key} is a required argument for  Cards.delete"
      end
    end
    parameters.each do |key, _|
      unless Array[:card_token].include?(key)
        puts " #{key} is an invalid argument for Cards.delete"
      end
    end
    response = request(method,url,options)
    card = Card.new(response.body)
    return card
  end
end