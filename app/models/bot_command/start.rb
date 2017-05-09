module BotCommand
  class Start < Base
    def should_start?
      text =~ /\A\/start/
    end

    def start
      msg = MessageFormatter.instructions
      send_html_message(msg)
      user.reset_next_bot_command
    end
  end
end
