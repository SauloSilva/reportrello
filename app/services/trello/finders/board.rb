module Trello
  module Finders
    class Board
      def initialize(report)
        @report = report
      end

      def find
        find_board
      end

      private

      attr_reader :report

      def user
        Trello::Finders::Member.new(report.user).find
      end

      def find_board
        user.boards.keep_if { |board| board.name == report.board_name }.first
      end
    end
  end
end