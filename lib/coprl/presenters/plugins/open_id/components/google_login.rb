module Coprl
  module Presenters
    module Plugins
      module OpenId
        class GoogleLogin < DSL::Components::Base

          attr_reader :google_client_id, :redirect_uri, :login_uri, :o_csrf_token

          def initialize(**attribs_, &block)
            super(type: :google_login, **attribs_, &block)
            @google_client_id = attribs.delete(:google_client_id) { ENV['GOOGLE_OAUTH_CLIENT_ID'] }
            @redirect_uri = attribs.delete(:redirect_uri)
            @o_csrf_token = attribs.delete(:o_csrf_token)
            @login_uri = generate_connect_link
            expand!
          end

          private

          def generate_connect_link
            params = {
              response_type: 'code',
              client_id: google_client_id,
              redirect_uri: redirect_uri,
              scope: 'openid email',
              state: o_csrf_token,
              nonce: SecureRandom.hex(12),
              access_type: 'offline'
            }

            "https://accounts.google.com/o/oauth2/v2/auth?#{params.to_query}"
          end

        end
      end
    end
  end
end
