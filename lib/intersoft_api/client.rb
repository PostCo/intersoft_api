require 'faraday'

module IntersoftAPI
  class Client
    BASE_URL = 'https://api.intersoftsapient.net/v4/'

    attr_reader :client_id, :client_secret, :adapter, :test, :access_token

    def initialize(client_id:, client_secret:, adapter: Faraday.default_adapter, test: false)
      @client_id = client_id
      @client_secret = client_secret
      @adapter = adapter
      @test = test
      fetch_access_token
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.headers['Authorization'] = "Bearer #{access_token}"
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
      end
    end

    def shipment
      ShipmentResource.new(self)
    end

    def shipping_account
      ShippingAccountResource.new(self)
    end

    def handle_response(response)
      error_message = response.body

      case response.status
      when 400
        raise Error, "A bad request or a validation exception has occurred. #{error_message}"
      when 401
        raise Error, "Invalid authorization credentials. #{error_message}"
      when 403
        raise Error, "Connection doesn't have permission to access the resource. #{error_message}"
      when 404
        raise Error, "The resource you have specified cannot be found. #{error_message}"
      when 429
        raise Error, "The API rate limit for your application has been exceeded. #{error_message}"
      when 500
        raise Error,
              "An unhandled error with the server. Contact the Intersoft team if problems persist. #{error_message}"
      when 503
        raise Error,
              "API is currently unavailable – typically due to a scheduled outage – try again soon. #{error_message}"
      end

      response
    end
    
    private
    
    def fetch_access_token
      response = handle_response(Faraday.post("https://authentication.intersoftsapient.net/connect/token", {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: 'client_credentials',
        }))
      @access_token = JSON.parse(response.body)['access_token']
    end
  end
end