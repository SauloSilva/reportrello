module Trello
  module Importers
    class Task
      def initialize(import)
        @import = import
      end

      def call
        import_tasks
        update_import
      end

      private

      attr_reader :import

      def find_cards
        Trello::Finders::List.new(import).find.cards
      end

      def import_tasks
        find_cards.each do |card|
          begin
            task = import.reports.last.tasks.create!(
              name: card.name
            )

            Trello::Importers::Checklist.new(task, card, import).call
          rescue ActiveRecord::RecordInvalid => invalid
            p "ERRORS: ", invalid.record.errors
            next
          end
        end
      end

      def update_import
        import.update_column(:imported_at, Time.now)
      end
    end
  end
end