module Trello
  module Reports
    class Task
      def initialize(environment)
        @environment = environment
      end

      def call
        environment_tasks
      end

      private

      attr_reader :environment

      def find_cards
        Trello::Finders::List.new(environment).find.cards
      end

      def environment_tasks
        find_cards.each do |card|
          begin
            task = environment.tasks.create!(
              name: card.name
            )

            Trello::Reports::Checklist.new(task, card, environment).call
          rescue ActiveRecord::RecordInvalid => invalid
            p "ERRORS: ", invalid.record.errors
            next
          end
        end
      end
    end
  end
end