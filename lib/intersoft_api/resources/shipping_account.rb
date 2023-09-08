# frozen_string_literal: true

module IntersoftAPI
  class ShippingAccountResource < Resource
    def create(attributes)
      ShippingAccount.new(post_request("shippingAccounts/rm", body: attributes).body)
    end

    def find(shipping_account_id)
      ShippingAccount.new(get_request("shippingAccounts/rm/#{shipping_account_id}").body)
    end
  end
end