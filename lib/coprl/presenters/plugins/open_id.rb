require_relative 'open_id/components/google_login'

module Coprl
  module Presenters
    module Plugins
      module OpenId
        # Components add new methods to the POM component hierarchy. They should add a component object to the
        # POM component stream. These components are the declarative instructions that are used to render a client.
        # POM components require corresponding views templates and JS that render them.
        # Name this method whatever you want.
        module DSLComponents
          def google_login(**attributes, &block)
            self << OpenId::GoogleLogin.new(parent: self, **attributes, &block)
          end
        end

        module WebClientComponents
          def view_dir_open_id(_pom)
            File.join(__dir__, '../../../..', 'views', 'components')
          end

          def render_google_login(comp,
                               render:,
                               components:,
                               index:)
            render.call :erb, :google_login, views: view_dir_open_id(comp),
                        locals: {comp: comp,
                                 components: components, index: index}
          end

        end
      end
    end
  end
end
