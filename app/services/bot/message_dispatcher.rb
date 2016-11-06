module Bot
  class MessageDispatcher
    attr_reader :message, :user

    def initialize(message, user)
      @message = message
      @user = user
    end

    def process
      Message.create(telegram_message_id: message[:update_id], message: message)
      
      start_command = Bot::Command::Transaction.new(user, message)

      if start_command.should_start?
        start_command.start
      else
        unknown_command
      end
    end

    private

    def unknown_command
      Bot::Command::Undefined.new(user, message).start
    end  
  end
end