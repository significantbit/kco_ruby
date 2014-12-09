# KcoRuby

[![Gem Version](https://badge.fury.io/rb/kco_ruby.svg)](http://badge.fury.io/rb/kco_ruby)
[![Code Climate](https://codeclimate.com/github/significantbit/kco_ruby/badges/gpa.svg)](https://codeclimate.com/github/significantbit/kco_ruby)
[![Test Coverage](https://codeclimate.com/github/significantbit/kco_ruby/badges/coverage.svg)](https://codeclimate.com/github/significantbit/kco_ruby)
[![Build Status](https://travis-ci.org/significantbit/kco_ruby.svg?branch=master)](https://travis-ci.org/significantbit/kco_ruby)

This gem is an unofficial port from Klarnas python API for Klarna Checkout

## Installation

Add this line to your application's Gemfile:

    gem 'kco_ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kco_ruby

## Usage

```
  cart = [
      {
          'quantity' => 1,
          'reference' => '123456789',
          'name' => 'Klarna t-shirt',
          'unit_price' => 12300,
          'discount_rate' => 1000,
          'tax_rate' => 2500
      }, {
          'quantity' => 1,
          'type' => 'shipping_fee',
          'reference' => 'SHIPPING',
          'name' => 'Shipping Fee',
          'unit_price' => 4900,
          'tax_rate' => 2500
      }
  ]

  create_data = {}
  create_data["cart"] = {"items" => []}

  cart.each do |item|
    create_data["cart"]["items"] << item
  end


  create_data['purchase_country'] = 'SE'
  create_data['purchase_currency'] = 'SEK'
  create_data['locale'] = 'sv-se'
  create_data['merchant'] = {
      'id' => '12345',
      'terms_uri' => 'http://example.com/terms.html',
      'checkout_uri' => 'http://example.com/checkout',
      'confirmation_uri' => ('http://example.com/thank-you' +
          '?sid=123&klarna_order={checkout.order.uri}'),
      'push_uri' => ('http://example.com/push' +
          '?sid=123&klarna_order={checkout.order.uri}')
  }

  KcoRuby::Order.base_uri = 'https://checkout.testdrive.klarna.com/checkout/orders'
  KcoRuby::Order.content_type =  'application/vnd.klarna.checkout.aggregated-order-v2+json'

  connector = KcoRuby.create_connector('secret')

  order = KcoRuby::Order.new(connector)
  order.create(create_data)
  order.fetch
```

## Documentation
You can use the official documentation from http://developers.klarna.com for Python with two exceptions:

1. All classes are found in KcoRuby module
2. Use Ruby hashes instead of Python Dict


## Todo
1. Add more tests for not so happy paths
2. Add more examples
3. Add Exception classes

## Contributing

1. Fork it ( https://github.com/[my-github-username]/kco_ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
The library is released under Apache License, Version 2.0
