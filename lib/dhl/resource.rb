module Dhl
  class Resource
    attr_reader :client, :require_token

    def initialize(client, require_token: true)
      @client = client
      @require_token = require_token
    end

    private

    def get_request(url, params: {}, headers: {})
      handle_response client.connection(require_token).get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection(require_token).post(url, body, headers)
    end

    def patch_request(url, body:, headers: {})
      handle_response client.connection(require_token).patch(url, body, headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection(require_token).put(url, body, headers)
    end

    def delete_request(url, params: {}, headers: {})
      handle_response client.connection(require_token).delete(url, params, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Request malformed. #{response.body["details"]}"
      when 401
        raise Error, "Invalid token"
      when 403
        raise Error, "Action not allowed. #{response.body}"
      when 404
        raise Error, "No results. #{response.body["details"]}"
      when 500
        raise Error, "Unable to perform the request due to server-side problems. #{response.body["details"]}"
      end

      response.body
    end
  end
end