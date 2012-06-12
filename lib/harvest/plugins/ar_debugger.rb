module ActiveResource
  class Base
    class << self

      # Tries to find a resource for a given name; if it fails, then the resource is created
      def find_or_create_resource_for(name)
        Project.logger = Rails.logger
        Project.logger.info "HERE! 1234567890 ***"
        super
      end

    end
  end
end