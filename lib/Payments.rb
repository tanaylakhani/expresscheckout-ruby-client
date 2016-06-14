require_relative 'util'

class Payments

  class Transaction

    attr_reader :order_id, :payment, :status, :txn_id
    class Payment
      attr_reader :authentication
      def initialize(options={})
        auth = Authentication.new(get_arg(options,'authentication'))
        @authentication = auth
      end

      class Authentication
        attr_reader :url, :method, :params
        def initialize(options={})
          @method = get_arg(options, 'method')
          @url = get_arg(options, 'url')
          @params = get_arg(options, 'params')
        end
      end

    end
    def initialize(options={})
      @order_id = get_arg(options, 'order_id')
      @txn_id = get_arg(options, 'txn_id')
      @status = get_arg(options, 'status')
      @payment = Payment.new(get_arg(options, 'payment'))
    end

  end

  def Payments.create_card_payment(options={})
    method = 'POST'
    url = '/txns'
    parameters = {}
    required_args = {}
    Array[:order_id, :merchant_id, :payment_method_type, :card_token, :card_number, :name_on_card,
          :card_exp_year, :card_exp_month, :card_security_code, :save_to_locker, :redirect_after_payment,
          :format].each do |key|
      required_args.store(key,'False')
    end
    options.each do |key, value|
      parameters.store(key,value)
      required_args[key] = 'True'
    end
    Array[:order_id, :merchant_id, :payment_method_type, :card_token, :card_number, :name_on_card,
          :card_exp_year, :card_exp_month, :card_security_code, :save_to_locker, :redirect_after_payment,
          :format].each do |key|
      if required_args[key] == 'False'
        raise "ERROR: #{key} is a required argument for Payments.create_card_payment"
      end
    end
    parameters.each do |key, _|
      unless Array[:order_id, :merchant_id, :payment_method_type, :payment_method, :card_token, :card_number, :name_on_card,
                   :card_exp_year, :card_exp_month, :card_security_code, :save_to_locker, :redirect_after_payment,
                   :format].include?(key)
        puts " #{key} is an invalid argument for Payments.create_card_payment"
      end
    end
    if parameters[:save_to_locker] != true and parameters[:save_to_locker] != false
      raise "ERROR: 'save_to_locker' should be true or false"
    end
    if parameters[:redirect_after_payment] != true and parameters[:redirect_after_payment] != false
      raise "ERROR: 'redirect_after_payment' should be true or false"
    end
    response = request(method,url,options)
    payment = Transaction.new(response.body)
    return payment
  end

  def Payments.create_net_banking_payment(options={})
    method = 'POST'
    url = '/txns'
    parameters = {}
    required_args = {}
    Array[:order_id, :merchant_id, :payment_method_type, :payment_method, :redirect_after_payment, :format].each do |key|
      required_args.store(key,'False')
    end
    options.each do |key, value|
      parameters.store(key,value)
      required_args[key] = 'True'
    end
    Array[:order_id, :merchant_id, :payment_method_type, :payment_method, :redirect_after_payment, :format].each do |key|
      if required_args[key] == 'False'
        raise "ERROR: #{key} is a required argument for Payments.create_net_banking_payment"
      end
    end
    parameters.each do |key, _|
      unless Array[:order_id, :merchant_id, :payment_method_type, :payment_method, :redirect_after_payment, :format].include?(key)
        puts " #{key} is an invalid argument for Payments.create_net_banking_payment"
      end
    end
    response = request(method,url,options)
    payment = Transaction.new(response.body)
    return payment
  end

end