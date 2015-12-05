module Trello
  module Finders
    class List
      def initialize(report)
        @report = report
      end

      def find
        find_list
      end

      private

      attr_reader :report

      def board
        Trello::Finders::Board.new(report).find
      end

      def find_list
        board.lists.keep_if do |list|
          list.name == report.list_name
        end.first
      end
    end
  end
end