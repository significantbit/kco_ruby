require 'spec_helper'

describe "Render checkout" do
  let(:connector){ KcoRuby.create_connector('secret') }

  describe "#create" do
    it "should get gui snippet" do

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

      order = KcoRuby::Order.new(connector)

      stub_request(:post, "https://checkout.testdrive.klarna.com/checkout/orders").
          to_return(:status => 201, :body => "", :headers => {location: 'https://order-url/item'})

      order.create(create_data)

      stub_request(:get, "https://order-url/item").
          to_return(:status => 200, :body => '{"gui":{"snippet": "snippet-code"}}')

      order.fetch
      expect(order["gui"]["snippet"]).to eq('snippet-code')

    end


  end

end