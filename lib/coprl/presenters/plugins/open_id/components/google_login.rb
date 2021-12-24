module Coprl
  module Presenters
    module Plugins
      module OpenId
        class GoogleLogin < DSL::Components::Base

          attr_reader :google_client_id, :google_client_secret, :login_uri

          def initialize(**attribs_, &block)
            super(type: :google_login, **attribs_, &block)
            @google_client_id = attribs.delete(:google_client_id) { ENV['GOOGLE_OAUTH_CLIENT_ID'] }
            @google_client_secret = attribs.delete(:google_client_secret) { ENV['GOOGLE_OAUTH_CLIENT_SECRET'] }
            @login_uri = attribs.delete(:login_uri)
            expand!
          end

          private

          def generate_connect_link
            # https://accounts.google.com/o/oauth2/v2/auth?
            # response_type=code&
            #   client_id=424911365001.apps.googleusercontent.com&
            #     scope=openid%20email&
            #   redirect_uri=https%3A//oauth2.example.com/code&
            #   state=security_token%3D138r5719ru3e1%26url%3Dhttps%3A%2F%2Foauth2-login-demo.example.com%2FmyHome&
            #   login_hint=jsmith@example.com&
            #                      nonce=0394852-3190485-2490358&
            #   hd=example.com
          end

        end
      end
    end
  end
end
