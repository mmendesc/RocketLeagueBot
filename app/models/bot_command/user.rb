module BotCommand
  class User < Base

    def user
      if @user.valid_for_search?
        msg = "Nickname: #{@user.player_id}, Platform: #{@user.platform}"
      elsif @user.platform.blank? && @user.player_id
        msg = "Nickname: #{@user.player_id}, Platform: need to set, send /platform yourplatform"
      elsif @user.platform && @user.player_id.blank?
        msg = "Platform: #{@user.platform}, Nickname: need to set, send /nickname yournickname"
      else
        msg = "You need to set your Nickname and Platform, send /help for instructions"
      end
      send_message(msg)
    end

  end
end
