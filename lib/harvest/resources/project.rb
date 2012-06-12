module Harvest
  module Resources
    # Supports the following:
    class Project < Harvest::HarvestResource
      include Harvest::Plugins::Toggleable
      
      def users
        user_class = Harvest::Resources::UserAssignment.clone
        user_class.project_id = self.id
        user_class
      end
      
      def tasks
        task_class = Harvest::Resources::TaskAssignment.clone
        task_class.project_id = self.id
        task_class
      end
      
      # Find all entries for the given project;
      # options[:from] and options[:to] are required;
      # include options[:user_id] to limit by a specific user.
      #   
      def entries(options={})
        validate_entries_options(options)
        entry_class = Harvest::Resources::Entry.clone
        entry_class.project_id = self.id
        
        Project.logger = Rails.logger
        
        begin
          formatted_params = format_params(options)
        rescue => e
          Project.logger.info "OPTIONS FORMAT ERROR FROM HARVEST GEM: " + e.to_s
        end

        entries = Array.new

        if formatted_params
          begin
            entries = Harvest::Resources::Entry(:project_id => self.id).find :all, :params => formatted_params, :format => :xml
          rescue => e
            Project.logger.info "PROBLEM FETCHING/SAVING DATA FROM HARVEST GEM: " + e.to_s
            Project.logger.info "CLASS NAME: \n" + entry_class.class.name
            Project.logger.info "BACKTRACE: \n" + e.backtrace.join("\n")
          end
        end

        entries
      end
      
      private
      
        def validate_entries_options(options)
          if [:from, :to].any? {|key| !options[key].respond_to?(:strftime) }
            raise ArgumentError, "Must specify :from and :to as dates."
          end
          
          if options[:from] > options[:to]
            raise ArgumentError, ":start must precede :end."
          end
        end
        
        def format_params(options)
          ops = { :from => Time.at(options[:from]).strftime("%Y%m%d"),
                  :to   => Time.at(options[:to]).strftime("%Y%m%d")}
          ops[:user_id] = options[:user_id] if options[:user_id]
          ops[:billable] = options[:billable] if options[:billable]
          ops[:only_unbilled] = options[:only_unbilled] if options[:only_unbilled]
          ops[:only_billed] = options[:only_billed] if options[:only_billed]
          ops[:is_closed] = options[:is_closed] if options[:is_closed]
          return ops
        end
          
    end
  end
end