require_relative 'Orders'
require_relative 'Cards'
require_relative 'Payments'
require_relative 'Wallets'
require_relative 'Customers'
require 'minitest/autorun'
require 'pp'

def pp(obj)
  text = obj.pretty_inspect
  output = ''
  text.each_line do |line|
    unless line.include?('=nil') or line.include?('=""')
      output += line
    end
  end
  puts output
end

class Test < Minitest::Test

  $api_key = '2CA3A4F3398B4B248787A32F3D9619E5'
  $environment = 'sandbox'

  def setup
    @timestamp = Time.now.to_i
  end

  def test_orders
    # Test for create
    order =   Orders.create(order_id:@timestamp, amount:1000)
    assert_equal('CREATED', order.status)
    #pp order

    # Test for get_status
    status = Orders.get_status(order_id:@timestamp)
    assert_equal(Float(status.order_id), @timestamp)
    #pp status

    # Test for list
    order_list = Orders.list
    refute_nil(order_list)
    #pp order_list

    # Test for update
    updated_order = Orders.update(order_id:@timestamp, amount:500)
    status = Orders.get_status(order_id:@timestamp)
    assert_equal(status.amount, updated_order.amount)
    #pp updated_order

    # Test for refund
    refunded_order = Orders.refund(unique_request_id: @timestamp, order_id: 1465833326,amount: 10)
    #pp refunded_order
  end

  def self.delete_all_cards
    card_list = Cards.list(:customer_id=>'user')
    card_list.each do |card|
      Cards.delete(:card_token=>card.token)
    end
  end

  def test_cards

    # Test for add
    card = Cards.add(merchant_id:'shreyas', customer_id:'user', customer_email:'abc@xyz.com',
        card_number:@timestamp*(10**6), card_exp_year:'20', card_exp_month:'12')
    refute_nil(card.reference)
    refute_nil(card.token)
    refute_nil(card.fingerprint)
    #pp card
    # Test for delete
    deleted_card = Cards.delete(card_token:card.token)
    assert(true,deleted_card.deleted)
    #pp deleted_card
    # Test for list
    #Test.delete_all_cards
    Cards.add(merchant_id:'shreyas', customer_id:'user', customer_email:'abc@xyz.com',
        card_number:@timestamp * (10 ** 6), card_exp_year:'20', card_exp_month:'12')
    Cards.add(merchant_id:'shreyas', customer_id:'user', customer_email:'abc@xyz.com',
        card_number:@timestamp * (10 ** 6)+1, card_exp_year:'20', card_exp_month:'12')
    card_list = Cards.list(customer_id:'user')
    refute_nil(card_list)
    assert_equal(card_list.length, 2)
    #pp card_list
    Test.delete_all_cards
  end

  def test_payments

    # Test for create_card_payment
    payment = Payments.create_card_payment(
        order_id:1470043679,
        merchant_id:'azhar',
        redirect_after_payment:false,
        card_number:'4242424242424242',
        name_on_card:'Customer',
        card_exp_year:'20',
        card_exp_month:'12',
        card_security_code:'123',
        save_to_locker:false)
    refute_nil(payment.txn_id)
    assert_equal(payment.status, 'PENDING_VBV')
    pp payment
    # Test for create_net_banking_payment
    payment = Payments.create_net_banking_payment(
        order_id:1470043679,
        merchant_id:'azhar',
        payment_method:'NB_DUMMY',
        redirect_after_payment:false)
    refute_nil(payment.txn_id)
    assert_equal(payment.status, 'PENDING_VBV')
    pp payment

    # Test for create_wallet_payment
    payment = Payments.create_wallet_payment(
        order_id:'check5',
        merchant_id:'azharamin',
        payment_method:'MOBIKWIK',
        redirect_after_payment:false)
    refute_nil(payment.txn_id)
    pp payment
    assert_match(/^(PENDING_VBV|CHARGED)$/,payment.status)
  end

  def test_customers
    #Add customer
    customer = Customers.add(
        object_reference_id: 'CustId123', 
        mobile_number: '7272727272', 
        email_address: 'az@temp.com', 
        first_name: 'temp',
        last_name: 'kumar',
        mobile_country_code: '35'
      )
    refute_nil(customer.id)
    pp customer

    List all customer 
    customer = Customers.list()
    pp customer
  end

  def test_wallets
    # List wallets by orderId
    wallets = Wallets.list(order_id:'check6')
    pp wallets
    refute_nil(wallets[0].id)

    # List wallets by customerId
    wallets = Wallets.list(customer_id:'guest_user_101')
    pp wallets
    refute_nil(wallets[0].id)

    # List wallets by customerId
    wallets = Wallets.refresh_balance(customer_id:'guest_user_104')
    pp wallets
    refute_nil(wallets[0].id)
  end
end

