module BotCommand
  class Username < Base

    def username
      nickname = @message.split('/username')[1].strip unless @message.split('/username')[1].blank?
      if !nickname.blank?
        @user.player_id = nickname
        @user.save
        msg = 'User registered.'
      else
        msg = "You must type your name or id"
      end
      send_message(msg)
    end

  end
end
