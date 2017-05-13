require './lib/scraper_api'
require './lib/scraper_api/scraper'
require './lib/scraper_api/parser'
module BotCommand
  class Divisions < Base

    def divisions
      msg = ScraperApi::Scraper.new(@user).divisions
      msg = MessageFormatter.new(msg).ranks
      send_message msg
    end

  end
end
