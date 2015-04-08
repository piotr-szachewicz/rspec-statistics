module Rspec
  module Statistics

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

      class Example
        IGNORED_QUERIES_PATTERN = %r{(
          pg_table|
          pg_attribute|
          pg_namespace|
          show\stables|
          pragma|
          sqlite_master/rollback|
          ^TRUNCATE TABLE|
          ^ALTER TABLE|
          ^BEGIN|
          ^COMMIT|
          ^ROLLBACK|
          ^RELEASE|
          ^SAVEPOINT
        )}xi

        def initialize(example)
          @example = example
          @counts  = Hash.new(0)
        end

        def query_count
          counts[:query_count]
        end

        def query_time
          counts[:query_time]
        end

        def request_count
          counts[:request_count]
        end

        def request_time
          counts[:request_time]
        end

        def log_query(query, start, finish)
          unless query[:sql] =~ IGNORED_QUERIES_PATTERN
            counts[:query_count] += 1
            counts[:query_time] += (finish - start)
          end
        end

        def log_request(request, start, finish)
          counts[:request_count] += 1
          counts[:request_time] += request[:view_runtime].to_f
        end


        def file
          metadata[:file_path]
        end

        def line_number
          metadata[:line_number]
        end

        def description
          metadata[:full_description]
        end

        def time
          execution_result.run_time
        end

        def result
          execution_result.status
        end

        private

        def metadata
          @example.metadata
        end

        def execution_result
          @example.execution_result
        end

        attr_reader :example, :counts
      end
    end

  end
end

