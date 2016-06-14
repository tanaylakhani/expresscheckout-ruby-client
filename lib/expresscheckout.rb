require "expresscheckout/version"

module Expresscheckout
	require 'unirest'
	require_relative 'Orders'
	require_relative 'Cards'
	require_relative 'Payments'

	$api_key = ''
	$environment = 'production'
	$version= {:JuspayAPILibrary=>'Ruby v1.0'}
end
