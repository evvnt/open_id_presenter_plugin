require_relative "helpers"

module Coprl
  module Presenters
    module Plugins
      module OpenId
        class GoogleLogin < DSL::Components::Base
          include Helpers

          attr_reader :google_client_id, :redirect_uri, :login_uri, :o_csrf_token, :scope

          def initialize(**attribs_, &block)
            super(type: :google_login, **attribs_, &block)
            @google_client_id = attribs.delete(:google_client_id) { ENV['GOOGLE_OAUTH_CLIENT_ID'] }
            @redirect_uri = attribs.delete(:redirect_uri)
            @o_csrf_token = attribs.delete(:o_csrf_token)
            @scope = scope_string(attribs.delete(:scope) { %w[openid email] })
            @login_uri = generate_connect_link
            expand!
          end

          private

          def generate_connect_link
            params = {
              response_type: 'code',
              client_id: google_client_id,
              redirect_uri: redirect_uri,
              scope: scope,
              state: o_csrf_token,
              nonce: SecureRandom.hex(12)
            }

            "https://accounts.google.com/o/oauth2/v2/auth?#{hash_to_query_string(params)}"
          end
        end
      end
    end
  end
end
