# Change Log

## [0.1.8] - 2017-02-18
### Added
- Added payment_method and payment_method_type in order class.
- Added implementation for Wallet create, authenticate, link & delink.
- Added implementation for get_payment_methods in Payments class.
- Added request parameters in error response.

## [0.1.7] - 2016-11-10
### Added
- PaymentLinks.java class, which contains the payment links for an order.
- Order uuid in order creation response with 'id' as field.
- Runtime dependency for unirest.

## [0.1.6] - 2016-08-24
### Added
- API implementation for Customer create, update, and get.
- API implementation for Wallet list and refresh.

### Changed
- API implementation for Order create, update, list, status and refund.
- API implementation for Transaction create.
- API implementation for Card create, list and delete.