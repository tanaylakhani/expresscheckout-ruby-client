require 'expresscheckout'
require 'pp'

$api_key = '187BF8D543A545789497F14FCAFBD85C'

@timestamp = Time.now.to_i

order = Orders.create(:order_id => @timestamp, :amount =>10)
pp order

pay = Orders.list()
pp pay