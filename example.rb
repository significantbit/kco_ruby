require 'kco_ruby'
require 'sinatra'
require 'pp'

get '/checkout' do
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
      'id' => 'eid',
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

  puts order.location
  order["gui"]["snippet"]
end
