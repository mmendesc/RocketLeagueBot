module BotCommand
  class Help < Base
    def help
      msg = MessageFormatter.help
      send_html_message(msg)
      user.reset_next_bot_command
    end
  end
end
