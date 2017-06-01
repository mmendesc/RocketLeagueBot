module BotCommand
  class User < Base

    def user
      if @user.valid_for_search?
        msg = "Username: #{@user.player_id}, Platform: #{@user.platform}"
      elsif @user.platform.blank? && @user.player_id
        msg = "Username: #{@user.player_id}, Platform: need to set, send /platform yourplatform"
      elsif @user.platform && @user.player_id.blank?
        msg = "Platform: #{@user.platform}, Username: need to set, send /username your username"
      else
        msg = "You need to set your Username and Platform, send /help for instructions."
      end
      send_message(msg)
      @user.reset_next_bot_command
    end

  end
end
