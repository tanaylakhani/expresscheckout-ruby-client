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
		:card_number => '4111111111111111',
		:card_exp_year => '2019',
		:card_exp_month => '07',
		:card_security_code => '123',
		:name_on_card => 'Sindbad'
)

print token