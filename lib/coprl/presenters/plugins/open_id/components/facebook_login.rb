module Coprl
  module Presenters
    module Plugins
      module OpenId
        class FacebookLogin < DSL::Components::Base
          attr_reader :facebook_app_id, :redirect_uri, :login_uri, :o_csrf_token

          def initialize(**attribs_, &block)
            super(type: :facebook_login, **attribs_, &block)
            @facebook_app_id = attribs.delete(:facebook_app_id) { ENV['FACEBOOK_APP_ID'] }
            @redirect_uri = attribs.delete(:redirect_uri)
            @o_csrf_token = attribs.delete(:o_csrf_token)
            @login_uri = generate_connect_link
            expand!
          end

          private

          def generate_connect_link
            params = {
              client_id: facebook_app_id,
              redirect_uri: redirect_uri,
              scope: 'email',
              state: o_csrf_token
            }

            "https://www.facebook.com/v12.0/dialog/oauth?#{params.to_query}"
          end
        end
      end
    end
  end
end
