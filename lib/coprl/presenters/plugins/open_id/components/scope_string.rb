module Coprl
  module Presenters
    module Plugins
      module OpenId
        module ScopeString
          def scope_string(scope)
            case scope
            when String
              scope
            when Array
              scope.map(&:to_s).join(' ')
            else
              raise ArgumentError, 'Scope must be a string or an array'
            end
          end
        end
      end
    end
  end
end
