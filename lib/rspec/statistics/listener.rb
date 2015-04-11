require 'rspec/statistics/example'

module RSpec
  module Statistics

    # Listener that is connected to the RSpec events.
    class Listener
      def start(notification)
        start_counting_queries
        start_counting_requests
      end

      def fields
        %w{ file line_number description result time query_count query_time request_count request_time  }
      end

      def example_started(notification)
        @current_example = Example.new(notification.example)
      end

      def example_finished(notification)
        output << fields.map { |field| @current_example.send(field)  }
      end

      alias :example_passed :example_finished
      alias :example_failed :example_finished

      private

      def output
        @output ||= CSV.open("spec_profiles.csv", "w").tap { |csv| csv << fields  }
      end

      def start_counting_queries
        ActiveSupport::Notifications.subscribe("sql.active_record") do |name, start, finish, id, query|
          @current_example.try(:log_query, query, start, finish)
        end
      end

      def start_counting_requests
        ActiveSupport::Notifications.subscribe("process_action.action_controller") do |name, start, finish, id, request|
          @current_example.try(:log_request, request, start, finish)
        end
      end
    end

  end
end

