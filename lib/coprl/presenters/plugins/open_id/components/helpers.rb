module Coprl
  module Presenters
    module Plugins
      module OpenId
        module Helpers
          def scope_string(scope)
            case scope
            when String
              scope
            when Array
              scope.map(&:to_s).join(" ")
            else
              raise ArgumentError, "Scope must be a string or an array"
            end
          end

          def html_safe(string)
            string.respond_to?(:html_safe) ? string.html_safe : string
          end

          def hash_to_query_string(hash)
            URI.encode_www_form(hash)
          end
        end
      end
    end
  end
end
