module Trello
  module Reports
    class Task
      def initialize(report)
        @report = report
      end

      def call
        report_tasks
      end

      private

      attr_reader :report

      def find_cards
        Trello::Finders::List.new(report).find.cards
      end

      def report_tasks
        find_cards.each do |card|
          begin
            task = report.tasks.create!(
              name: card.name
            )

            Trello::Reports::Checklist.new(task, card, report).call
          rescue ActiveRecord::RecordInvalid => invalid
            p "ERRORS: ", invalid.record.errors
            next
          end
        end

        report.update_attributes(reported_at: Time.now, status: 'success', log: 'Imported has been success!')
      rescue Trello::Errors::BoardNotFound, Trello::Errors::ListNotFound => error
        report.update_attributes(status: 'warning', log: error.message)
      end
    end
  end
end