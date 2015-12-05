module Trello
  module Finders
    class Board
      def initialize(import)
        @import = import
      end

      def find
        find_board
      end

      private

      attr_reader :import

      def user
        Trello::Finders::Member.new(import.user).find
      end

      def find_board
        user.boards.keep_if { |board| board.name == import.board_name }.first
      end
    end
  end
end