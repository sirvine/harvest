module ActiveResource
  class Base
    class << self

      # Tries to find a resource for a given name; if it fails, then the resource is created
      def find_or_create_resource_for(name)
        return reflections[name.to_sym].klass if reflections.key?(name.to_sym)
        resource_name = name.to_s.camelize

        Project.logger = Rails.logger
        Project.logger.info "HERE! 1234567890 ***"

        const_args = [resource_name, false]
        if self.class.const_defined?(*const_args)
          self.class.const_get(*const_args)
        else
          ancestors = self.class.name.split("::")
          if ancestors.size > 1
            find_or_create_resource_in_modules(resource_name, ancestors)
          else
            if Object.const_defined?(*const_args)
              Object.const_get(*const_args)
            else
              create_resource_for(resource_name)
            end
          end
        end
      end

    end
  end
end