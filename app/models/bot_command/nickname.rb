module BotCommand
  class Nickname < Base

    def nickname
      nickname = @message.split('/nickname')[1].strip unless @message.split('/nickname')[1].blank?
      if !nickname.blank?
        @user.player_id = nickname
        @user.save
        msg = 'Nickname registered.'
      else
        msg = "You must type your name or id"
      end
      send_message(msg)
    end

  end
end
