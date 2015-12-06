module Trello
  module Errors
    class Standard < StandardError; end

    class BoardNotFound < Standard
      def message
        'Board is not found'
      end
    end

    class ListNotFound < Standard
      def message
        'List is not found'
      end
    end
  end
end