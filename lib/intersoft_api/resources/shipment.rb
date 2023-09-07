# frozen_string_literal: true

module IntersoftAPI
  class ShipmentResource < Resource
    def create(attributes)
      Shipment.new(post_request("shipments/rm", body: attributes).body)
    end

    def generate_label_qr_code(shipment_id)
      Shipment.new(get_request("shipments/printMyLabelQRCode/rm/#{shipment_id}").body)
    end
  end
end