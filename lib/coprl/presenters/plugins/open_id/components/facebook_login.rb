require_relative 'scope_string'

module Coprl
  module Presenters
    module Plugins
      module OpenId
        class FacebookLogin < DSL::Components::Base
          include ScopeString

          attr_reader :facebook_app_id, :redirect_uri, :login_uri, :o_csrf_token, :scope

          def initialize(**attribs_, &block)
            super(type: :facebook_login, **attribs_, &block)
            @facebook_app_id = attribs.delete(:facebook_app_id) { ENV['FACEBOOK_APP_ID'] }
            @redirect_uri = attribs.delete(:redirect_uri)
            @o_csrf_token = attribs.delete(:o_csrf_token)
            @scope = scope_string(attribs.delete(:scope) { %w[email] })
            @login_uri = generate_connect_link
            expand!
          end

          private

          def generate_connect_link
            params = {
              client_id: facebook_app_id,
              redirect_uri: redirect_uri,
              scope: scope,
              state: o_csrf_token
            }

            "https://www.facebook.com/v18.0/dialog/oauth?#{params.to_query}"
          end
        end
      end
    end
  end
end
