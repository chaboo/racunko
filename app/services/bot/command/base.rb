require 'telegram/bot'

module Bot
  module Command
    class Base
      attr_reader :user, :message, :api

      def initialize(user, message)
        @user = user
        @message = message
        token = Rails.application.secrets.bot_token
        @api = ::Telegram::Bot::Api.new(token)
      end

      def should_start?
        raise NotImplementedError
      end

      def start
        raise NotImplementedError
      end

      protected

      def send_message(text, options={})
        if Rails.env.production?
          @api.call('sendMessage', chat_id: @user.telegram_id, text: text)
        elsif Rails.env.development?
          @api.call('sendMessage', chat_id: dev_chat_id, text: text)
        end
 
        log("sendMessage chat_id: #{@user.telegram_id} text: #{text}")
      end

      def text
        @message[:message][:text]
      end

      def from
        @message[:message][:from]
      end

      def log(message)
        Rails.logger.info(message)
      end

      def dev_chat_id
        ENV["DEV_CHAT_ID"]
      end
    end
  end
end