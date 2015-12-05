module Trello
  module Finders
    class Member
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def find
        configure
        find_me
      end

      private

      def configure
        Trello.configure do |config|
          config.developer_public_key = '64b59fd7744b9bc5b2a7259d6bced78d'
          config.member_token = user.token
        end
      end

      def find_me
        Trello::Member.find(user.username)
      end
    end
  end
end