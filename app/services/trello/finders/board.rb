module Trello
  module Finders
    class Board
      def initialize(environment)
        @environment = environment
      end

      def find
        find_board
      end

      private

      attr_reader :environment

      def user
        Trello::Finders::Member.new(environment.report.user).find
      end

      def find_board
        board = user.boards.keep_if { |board| board.name == environment.board_name }.first

        raise Trello::Errors::BoardNotFound if board.nil?

        board
      end
    end
  end
end