# frozen_string_literal: true

module IntersoftAPI
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body, headers)
    end

    private

    def handle_response(response)
      client.handle_response(response)
    end
  end
end