require './lib/scraper_api'
require './lib/scraper_api/scraper'
require './lib/scraper_api/parser'
module BotCommand
  class Rank < Base

    def rank
      msg = ScraperApi::Scraper.new(@user).divisions
      msg = MessageFormatter.new(msg).ranks
      send_html_message msg
      @user.reset_next_bot_command
    end

  end
end
