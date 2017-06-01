require './lib/scraper_api'
require './lib/scraper_api/scraper'
require './lib/scraper_api/parser'
module BotCommand
  class Stats < Base

    def stats
      msg = ScraperApi::Scraper.new(@user).stats
      msg = MessageFormatter.new(msg).stats
      send_message msg
      @user.reset_next_bot_command
    end

  end
end
