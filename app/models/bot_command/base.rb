require 'telegram/bot'

module BotCommand
  class Base
    attr_reader :user, :message, :api

    def initialize(user, message = nil)
      @user = user
      @message = message
      token = Figaro.env.bot_token
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
      @api.call('sendMessage', chat_id: @user.chat_id, text: text)
      Rails.logger.debug  "sending '#{text}' to #{@user.first_name}"
    end

    def send_html_message(text,options={})
      @api.call('sendMessage', chat_id: @user.chat_id, text: text, parse_mode: 'HTML', disable_web_page_preview: true)
      Rails.logger.debug "sending '#{text}' to #{@user.first_name}"
    end

    def text
      @message[:message][:text]
    end

    def from
      @message[:message][:from]
    end
  end
end
