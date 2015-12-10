module Trello
  module Finders
    class List
      def initialize(environment)
        @environment = environment
      end

      def find
        find_list
      end

      private

      attr_reader :environment

      def board
        Trello::Finders::Board.new(environment).find
      end

      def find_list
        list = board.lists.keep_if do |list|
          list.name == environment.list_name
        end.first

        raise Trello::Errors::ListNotFound if list.nil?

        list
      end
    end
  end
end