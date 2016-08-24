require_relative 'util'

class Wallets

  # noinspection ALL
  class Wallet

    attr_reader :id, :wallet, :object, :token, :current_balance, :last_refresh

    def initialize(options = {})
      @id = get_arg(options, 'id')
      @object = get_arg(options, 'object')
      @wallet = get_arg(options, 'wallet')
      @token = get_arg(options, 'token')
      @current_balance = get_arg(options, 'current_balance')
      @last_refresh = get_arg(options, 'last_refreshed')
    end

  end

  def Wallets.create(options={})
    raise "ERROR: Not Implemented"
  end

  def Wallets.list(options={})
    order = get_arg(options, :order_id)
    customer = get_arg(options, :customer_id)

    if customer == NIL and order == NIL
      raise InvalidArguementError.new("ERROR: `customer_id` or `order_id` is required parameter for Wallets.list()")
    end

    if customer
      url = "/customers/#{customer}/wallets"
    else
      url = "/orders/#{order}/wallets"
    end

    method = 'GET'
    response = Array(request(method,url,{}).body['list'])
    wallets = []
    i=0
    while i != response.count
      wallet = Wallet.new(response[i])
      wallets.push(wallet)
      i+=1
    end
    return wallets
  end

  def Wallets.refresh_balance(options={})
    customer = get_arg(options, :customer_id)

    if customer == NIL
      raise InvalidArguementError.new("ERROR: `customer_id` is required parameter for Wallets.refresh_balance()")
    end

    url = "/customers/#{customer}/wallets/refresh-balances"
    method = 'GET'
    response = Array(request(method,url,{}).body['list'])
    wallets = []
    i=0
    while i != response.count
      wallet = Wallet.new(response[i])
      wallets.push(wallet)
      i+=1
    end
    return wallets
  end    

  def Wallets.delete(options={})
    raise "ERROR: Not Implemented"
  end
end