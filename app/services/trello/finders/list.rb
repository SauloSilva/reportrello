module Trello
  module Finders
    class List
      def initialize(import)
        @import = import
      end

      def find
        find_list
      end

      private

      attr_reader :import

      def board
        Trello::Finders::Board.new(import).find
      end

      def find_list
        board.lists.keep_if do |list|
          list.name == import.list_name
        end.first
      end
    end
  end
end