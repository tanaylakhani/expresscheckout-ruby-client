require_relative 'util'
require_relative 'Cards'

class Orders

  @all_input_params = Array[:order_id, :amount, :currency, :customer_id, :customer_email, :customer_phone,
        :description, :product_id, :gateway_id, :return_url, :billing_address_first_name,
        :billing_address_last_name, :billing_address_line1, :billing_address_line2,
        :billing_address_line3, :billing_address_city, :billing_address_state,
        :billing_address_country, :billing_address_postal_code, :billing_address_phone,
        :billing_address_country_code_iso, :shipping_address_first_name,
        :shipping_address_last_name, :shipping_address_line1, :shipping_address_line2,
        :shipping_address_line3, :shipping_address_city, :shipping_address_state,
        :shipping_address_country, :shipping_address_postal_code, :shipping_address_phone,
        :shipping_address_country_code_iso, :udf1, :udf2, :udf3, :udf4, :udf5, :udf6, :udf7,
        :udf8, :udf9, :udf10]

  # noinspection ALL
  class Order

    attr_reader :id, :order_id, :product_id, :billing_address, :udf10, :refunds, :return_url, :bank_error_code, :merchant_id, :amount, :shipping_address, :gateway_id, :customer_id, :gateway_response, :amount_refunded, :udf7, :customer_email, :udf8, :udf9, :txn_id, :udf3, :udf4, :description, :udf5, :bank_error_message, :udf6, :udf1, :udf2, :status, :customer_phone, :currency, :refunded, :status_id, :payment_links
    class Address

      attr_reader :state, :line1, :country, :country_code_iso, :type, :line3, :postal_code, :line2, :first_name, :last_name, :city, :phone

      def initialize(address_type, options = {})
        @type = address_type
        @first_name = get_arg(options, (@type + '_address_first_name'))
        @last_name = get_arg(options, (@type + '_address_last_name'))
        @line1 = get_arg(options, (@type + '_address_line1'))
        @line2 = get_arg(options, (@type + '_address_line2'))
        @line3 = get_arg(options, (@type + '_address_line3'))
        @city = get_arg(options, (@type + '_address_city'))
        @state = get_arg(options, (@type + '_address_state'))
        @country = get_arg(options, (@type + '_address_country'))
        @postal_code = get_arg(options, (@type + '_address_postal_code'))
        @phone = get_arg(options, (@type + '_address_phone'))
        @country_code_iso = get_arg(options, (@type + '_address_country_code_iso'))
      end

    end

    class Refund

      attr_reader :amount, :created, :id, :ref, :status

      def initialize(options = {})
        @id = get_arg(options, 'refund_id')
        @ref = get_arg(options, 'ref')
        @amount = get_arg(options, 'amount')
        @created = get_arg(options, 'created')
        @status = get_arg(options, 'status')
      end

    end

    class GatewayResponse

      attr_reader :rrn, :epg_txn_id, :resp_message, :auth_id_code, :resp_code, :txn_id

      def initialize(options = {})
        @rrn = get_arg(options, 'rrn')
        @epg_txn_id = get_arg(options, 'epg_txn_id')
        @auth_id_code = get_arg(options, 'auth_id_code')
        @txn_id = get_arg(options, 'txn_id')
        @resp_code = get_arg(options, 'resp_code')
        @resp_message = get_arg(options, 'resp_message')
      end

    end

    class PaymentLink

      attr_reader :web, :mobile, :iframe

      def initialize(options = {})
        @web = get_arg(options, 'web')
        @mobile = get_arg(options, 'mobile')
        @iframe = get_arg(options, 'iframe')
      end

    end

    def initialize(options = {})

      if check_param(options,"billing_address")
        billing_address = Address.new("billing", options)
      else
        billing_address = nil
      end
      if check_param(options,"shiiping_address")
        shipping_address = Address.new("shipping", options)
      else
        shipping_address = nil
      end
      if check_param(options,"cards")
        card = Cards::Card.new(get_arg(options, 'card'))
      else
        card = nil
      end
      if get_arg(options,"payment_gateway_response") != nil
        gateway_response = GatewayResponse.new(get_arg(options, 'payment_gateway_response'))
      else
        gateway_response = nil
      end
      refunds_array =  Array(get_arg(options,'refunds'))
      if refunds_array.length != 0
        refunds = []
        i=0
        while i < refunds_array.count()
          refund = refunds_array[i]
          refund_obj = Refund.new(refund)
          refunds.push(refund_obj)
          i+=1
        end
      else
        refunds = nil
      end

      payment_links = PaymentLink.new(get_arg(options, 'payment_links'))
      
      @id = get_arg(options, 'id')
      @merchant_id = get_arg(options, 'merchant_id')
      @order_id = get_arg(options, 'order_id')
      @status = get_arg(options, 'status')
      @status_id = get_arg(options, 'status_id')
      @amount = get_arg(options, 'amount')
      @currency = get_arg(options, 'currency')
      @customer_id = get_arg(options, 'customer_id')
      @customer_email = get_arg(options, 'customer_email')
      @customer_phone = get_arg(options, 'customer_phone')
      @product_id = get_arg(options, 'product_id')
      @return_url = get_arg(options, 'return_url')
      @description = get_arg(options, 'description')
      @billing_address = billing_address
      @shipping_address = shipping_address
      @udf1 = get_arg(options, 'udf1')
      @udf2 = get_arg(options, 'udf2')
      @udf3 = get_arg(options, 'udf3')
      @udf4 = get_arg(options, 'udf4')
      @udf5 = get_arg(options, 'udf5')
      @udf6 = get_arg(options, 'udf6')
      @udf7 = get_arg(options, 'udf7')
      @udf8 = get_arg(options, 'udf8')
      @udf9 = get_arg(options, 'udf9')
      @udf10 = get_arg(options, 'udf10')
      @txn_id = get_arg(options, 'txn_id')
      @gateway_id = get_arg(options, 'gateway_id')
      @bank_error_code = get_arg(options, 'bank_error_code')
      @bank_error_message = get_arg(options, 'bank_error_message')
      @refunded = get_arg(options, 'refunded')
      @amount_refunded = get_arg(options, 'amount_refunded')
      @card = card
      @gateway_response = gateway_response
      @refunds = refunds
      @payment_links = payment_links
    end

  end

  def Orders.create(options={})
    order = get_arg(options, :order_id)
    if order == NIL
      raise InvalidArguementError.new("ERROR: `order_id` is required parameter for Orders.create()")
    end

    method = 'POST'
    url = '/order/create'
    response = request(method,url,options)
    order = Order.new(response.body)
    return order
  end

  def Orders.status(options={})
    order = get_arg(options, :order_id)
    if order == NIL
      raise InvalidArguementError.new("ERROR: `order_id` is required parameter for Orders.status()")
    end

    method = 'GET'
    url = '/order/status'
    response = request(method,url,options)
    order = Order.new(response.body)
    return order
  end

  def Orders.list(options={})
    method = 'GET'
    url = '/order/list'
    response = request(method,url,options).body
    orders = {count: response['count'],total: response['total'], offset: response['offset'] }
    list = []
    order_list = Array(response['list'])
    order_list.each do |orderData|
      order = Order.new(orderData)
      list.push(order)
    end
    orders[:list] = list
    return orders
  end

  def Orders.update(options={})
    order = get_arg(options, :order_id)
    if order == NIL
      raise InvalidArguementError.new("ERROR: `order_id` is required parameter for Orders.update()")
    end

    method = 'POST'
    url = '/order/create'
    response = request(method,url,options)
    order = Order.new(response.body)
    return order
  end

  def Orders.refund(options={})
    order = get_arg(options, :order_id)
    unique_request = get_arg(options, :unique_request_id)
    if order == NIL or unique_request == NIL
      raise InvalidArguementError.new("ERROR: `order_id` & `unique_request_id` is required parameter for Orders.refund()")
    end

    method = 'POST'
    url = '/order/refund'
    response = request(method,url,options)
    order = Order.new(response.body)
    return order
  end

end