module BotCommand
  class Undefined < Base
    def start
      send_message('Unknown command.')
    end
  end
end
