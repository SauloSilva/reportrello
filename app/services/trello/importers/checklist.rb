module Trello
  module Importers
    class Checklist
      def initialize(task, card, import)
        @task = task
        @card = card
        @import = import
      end

      def call
        import_checklists
      end

      private

      attr_reader :task, :card, :import

      def checklist
        @checklist ||= begin
          found_checklist = card.checklists.keep_if  do |item|
            item.name == import.checklist_name
          end.first

          return if found_checklist.nil?

          Trello::Checklist.find(found_checklist.id)
        end
      end

      def complete_item(item)
        checklist.add_item(item.name, true)
        checklist.delete_checklist_item(item.id)
      end

      def import_checklists
        return if checklist.nil?

        checklist.items.map do |item|
          begin
            complete_item(item)
            task.checklists.create!(description: item.name)
          rescue ActiveRecord::RecordInvalid => invalid
            p "ERRORS: ", invalid.record.errors
            next
          end
        end
      end
    end
  end
end