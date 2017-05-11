module BotCommand
  class Stats < Base

    def stats
      msg = ScraperApi::Scraper.new(@user).stats
      msg = MessageFormatter.new(msg).stats
      send_message msg
    end

  end
end
