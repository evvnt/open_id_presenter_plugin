require 'uri'

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

        end
      end
    end
  end
end
