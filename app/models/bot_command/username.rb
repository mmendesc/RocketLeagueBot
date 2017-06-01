module BotCommand
  class Username < Base

    # def username
    #   nickname = @message.split('/username')[1].strip unless @message.split('/username')[1].blank?
    #   if !nickname.blank?
    #     @user.player_id = nickname
    #     @user.save
    #     msg = 'User registered.'
    #   else
    #     msg = "You must type your name or id"
    #   end
    #   send_message(msg)
    # end

    def username
      msg = 'Now type your username'
      @user.set_next_bot_command('BotCommand::Username','set_username')
      @user.save
      send_message msg
    end


    def set_username
      @user.player_id = @message
      @user.bot_command = {}
      @user.save
      msg = 'Username registered successfuly'
      send_message msg
    end

  end
end