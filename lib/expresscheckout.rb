require "expresscheckout/version"

module Expresscheckout
	require_relative 'Orders'
	require_relative 'Cards'
	require_relative 'Payments'
	require_relative 'Customers'
	require_relative 'Wallets'

	$api_key = 'EEA8D09ACF3941758F9AA91754A5C631'
	$environment = 'sandbox'
	$version= {:JuspayAPILibrary=>'Ruby v1.0'}
end

require 'unirest'
