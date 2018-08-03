require './lib/scraper_api'
require './lib/scraper_api/scraper'
require './lib/scraper_api/parser'
module BotCommand
  class Stats < Base

    def stats
      checked = check_user
      unless checked[:invalid]
        msg = ScraperApi::Scraper.new(@user).stats
        if msg
          msg = MessageFormatter.new(msg).stats
        else
          msg = "We didn't found your stats, please check your user again."
        end
        send_message msg
      else
        send_message checked[:msg]
      end
      @user.reset_next_bot_command
    end

    def check_user
      if @user.valid_for_search?
        checked = {invalid: false}
      elsif @user.platform.blank? && @user.player_id
        msg = "Username: #{@user.player_id}, Platform: need to set, send /platform yourplatform"
        invalid = true
        checked = {invalid: true, msg: "Username: #{@user.player_id}, Platform: need to set, send /platform yourplatform"}
      elsif @user.platform && @user.player_id.blank?
        msg = "Platform: #{@user.platform}, Username: need to set, send /username your username"
        invalid = true
        checked = {invalid: true, msg: "Platform: #{@user.platform}, Username: need to set, send /username your username"}
      else
        msg = "You need to set your Username and Platform, send /help for instructions."
        invalid = true
        checked = {invalid: true, msg: "You need to set your Username and Platform, send /help for instructions."}
      end
      checked
    end


  end
end
