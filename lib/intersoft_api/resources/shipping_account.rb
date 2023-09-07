# frozen_string_literal: true

module IntersoftAPI
  class ShippingAccountResource < Resource
    def create(attributes)
      ShippingAccount.new(post_request("shippingAccounts/rm", body: attributes).body)
    end

    def find(id)
      ShippingAccount.new(get_request("shippingAccounts/rm/#{id}").body)
    end
  end
end