module IntersoftAPI
  class ShipmentResource < Resource
    def create(attributes)
      Shipment.new(post_request("shipments/rm", body: attributes).body)
    end

    def generate_label_qr_code(shipment_id)
      Shipment.new(get_request("shipments/printMyLabelQRCode/rm/#{shipment_id}").body)
    end

    def all(shipping_location_id, options = {})
      url = "shipments/#{shipping_location_id}"
      options = options.slice(:shipping_account_id, :carrier_code, :status, :destination_country_code, :date_from, :date_to, :page_size, :page_number)
      options = options.transform_keys { |key| key.to_s.camelize(:lower) }
      url += "?#{options.to_query}" if options.any?

      Shipment.new(get_request(url).body)
    end
  end
end