require "expresscheckout/version"

module Expresscheckout
	require_relative 'Orders'
	require_relative 'Cards'
	require_relative 'Payments'
	require_relative 'Customers'
	require_relative 'Wallets'

	$api_key = nil
	$environment = 'production'
	$api_version= '2016-07-19'
end

require 'unirest'
