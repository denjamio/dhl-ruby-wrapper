module Dhl
  class AuthenticateResource < Resource
    def api_key(credentials)
      Token.new post_request("authenticate/api-key", body: credentials)
    end

    def refresh_token(**credentials)
      Token.new post_request("authenticate/refresh-token", body: credentials)
    end
  end
end