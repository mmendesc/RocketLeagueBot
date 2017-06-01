module BotCommand
  class Undefined < Base
    def start
      send_message('Unknown command.')
      @user.reset_next_bot_command
    end
  end
end
