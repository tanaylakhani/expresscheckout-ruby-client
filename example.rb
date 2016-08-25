require 'expresscheckout'
require 'pp'

$api_key = '187BF8D543A545789497F14FCAFBD85C'

@timestamp = Time.now.to_i

order = Orders.create(:order_id => @timestamp, :amount =>10)
pp order

list = Orders.list()
pp list

token = Cards.tokenize(
		:merchant_id => 'testmerchant',
		:customer_id => 'yourCustId3',
		:customer_email => 'a@b.com',
		:card_number => '4242424242424242',
		:card_exp_year => '2019',
		:card_exp_month => '12',
		:card_security_code => '123')

print token