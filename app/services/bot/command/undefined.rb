module Bot
  module Command
    class Undefined < Base
      def start
        send_message('Unknown command. Type /start if you are a new user, else type the appropriate command.')
      end
    end
  end
end