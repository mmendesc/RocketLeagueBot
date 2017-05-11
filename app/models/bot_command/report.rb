module BotCommand
  class Report < Base

    def report
      send_message @message
    end
  end
end
