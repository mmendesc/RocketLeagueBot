module BotCommand
  class Start < Base

    def start
      msg = MessageFormatter.instructions
      send_html_message(msg)
      user.reset_next_bot_command
    end
  end
end
