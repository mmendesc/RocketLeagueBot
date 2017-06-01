module BotCommand
  class Platform < Base

    # def platform
    #   platform = @message.split('/platform')[1].strip unless @message.split('/platform')[1].blank?
    #   if ['steam','ps','xbox'].include?(platform)
    #     @user.platform = platform
    #     @user.save
    #     msg = 'Platform registered.'
    #   else
    #     msg = "Platform name invalid , options are: steam,ps,xbox"
    #   end
    #   send_message(msg)
    # end

    def platform
      msg = 'Type the platform you play'
      @user.set_next_bot_command('BotCommand::Platform','set_platform')
      @user.save
      send_message msg
    end

    def set_platform
      if ['steam','ps','xbox'].include?(@message.downcase)
        @user.platform = @message.downcase
        @user.bot_command = {}
        @user.save
        msg = 'Platform registered.'
      else
        msg = "Platform name invalid , options are: steam,ps,xbox."
      end
      send_message(msg)
    end

  end
end
