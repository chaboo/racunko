module Bot
  module Command
    class Transaction < Base
      def should_start?
        text =~ /\A\/transaction/
      end

      def start
        send_message('I got my first transaction, yay!')
      end
    end
  end
end