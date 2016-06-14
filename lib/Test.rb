require_relative 'Orders'
require_relative 'Cards'
require_relative 'Payments'
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

  $api_key = '4168A8A476B84DBCAF409C24F379BAC5'
  $environment = 'production'

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
        order_id:1465893617,
        merchant_id:'juspay_recharge',
        payment_method_type:'CARD',
        card_token:'68d6b0c6-6e77-473f-a05c-b460ef983fd8',
        redirect_after_payment:false,
        format:'json',
        card_number:'5243681100075285',
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
        order_id:1465893617,
        merchant_id:'juspay_recharge',
        payment_method_type:'NB',
        payment_method:'NB_ICICI',
        redirect_after_payment:false,
        format:'json')
    refute_nil(payment.txn_id)
    assert_equal(payment.status, 'PENDING_VBV')
    pp payment
  end
end

