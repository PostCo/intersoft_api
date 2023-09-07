# frozen_string_literal: true

require_relative "intersoft_api/version"

module IntersoftAPI
  autoload :Client, 'intersoft_api/client'
  autoload :Error, 'intersoft_api/error'
  autoload :Object, 'intersoft_api/object'
  autoload :Resource, 'intersoft_api/resource'

  autoload :Shipment, 'intersoft_api/objects/shipment'
  autoload :ShippingAccount, 'intersoft_api/objects/shipping_account'

  autoload :ShipmentResource, 'intersoft_api/resources/shipment'
  autoload :ShippingAccountResource, 'intersoft_api/resources/shipping_account'
end
