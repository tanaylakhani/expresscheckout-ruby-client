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

  def Wallets.add(options={})
    raise "ERROR: Not Implemented"
  end

  def Wallets.list(options={})
    order = get_arg(options, :order_id)
    customer = get_arg(options, :customer_id)

    if customer == NIL and order == NIL
      raise Exception('customer_id or order_id is a required argument for Wallets.list()\n')
    end

    if customer
      url = "/customers/#{customer}/wallets"
    else
      url = "/orders/#{order}/wallets"
    end

    method = 'GET'
    parameters = {}

    response = Array(request(method,url,parameters).body['list'])
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
      raise Exception('customer_id is a required argument for Wallets.list()\n')
    end

    url = "/customers/#{customer}/wallets/refresh-balances"
    method = 'GET'
    parameters = {}

    response = Array(request(method,url,parameters).body['list'])
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