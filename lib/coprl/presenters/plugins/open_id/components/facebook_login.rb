module Coprl
  module Presenters
    module Plugins
      module OpenId
        class FacebookLogin < DSL::Components::Base
          attr_reader :facebook_app_id, :login_url, :state

          def initialize(**attribs_, &block)
            super(type: :facebook_login, **attribs_, &block)
            @facebook_app_id = attribs.delete(:facebook_app_id) { ENV['FACEBOOK_APP_ID'] }
            @redirect_uri = attribs.delete(:redirect_uri)
            @state = attribs.delete(:state)
            expand!
          end

          def login_url
            #@login_url =
          end

        end
      end
    end
  end
end
