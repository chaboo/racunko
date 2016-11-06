class BotMessageDispatcher
  attr_reader :message, :user

  def initialize(message, user)
    @message = message
    @user = user
  end

  def process
    Message.create(telegram_message_id: message[:update_id], message: message)
  end
end