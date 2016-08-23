require "expresscheckout/version"

module Expresscheckout
	require_relative 'Orders'
	require_relative 'Cards'
	require_relative 'Payments'
	require_relative 'Customers'
	require_relative 'Wallets'

	$api_key = nil
	$environment = 'staging'
	$version= {:JuspayAPILibrary=>'Ruby v1.0'}
end

require 'unirest'
