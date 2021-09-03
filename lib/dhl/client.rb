module Dhl
  class Client
    attr_reader :access_token, :env, :adapter

    def initialize(user_id: , key:, env: :live, adapter: Faraday.default_adapter)
      @env = env
      @adapter = adapter
      auth(userId: user_id, key: key)
    end


    def drafts
      DraftsResource.new(self)
    end

    def connection(require_token: true)
      Faraday.new(base_url) do |conn|
        conn.request :authorization, :Bearer, get_access_token if require_token
        conn.request :json

        conn.response :json, content_type: "application/json"
        conn.response :logger

        conn.adapter adapter
      end
    end

    private

    attr_reader :refresh_token, :access_token_expiration
    attr_writer :access_token, :access_token_expiration, :refresh_token

    def auth(**credentials)
      set_access_token AuthenticateResource.new(self, require_token: false).api_key(credentials)
    end

    def reauth
      set_access_token AuthenticateResource.new(self, require_token: false).refresh_token(refreshToken: refresh_token)
    end

    def get_access_token
      return access_token if valid_access_token?
      reauth
    end

    def set_access_token(auth_response)
      @access_token = auth_response.accessToken
      @access_token_expiration = auth_response.accessTokenExpiration
      @refresh_token = auth_response.refreshToken
      @access_token
    end

    def valid_access_token?
      Time.at(access_token_expiration) - 30 > Time.now
    end

    def base_url
      case env
      when :live
        "https://api-gw.dhlparcel.nl"
      when :test
        "https://api-gw-accept.dhlparcel.nl"
      end
    end
  end
end