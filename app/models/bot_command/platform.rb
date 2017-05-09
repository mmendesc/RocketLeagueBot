module BotCommand
  class Platform < Base

    def platform
      platform = @message.split('/platform')[1].strip unless @message.split('/platform')[1].blank?
      if ['steam','ps','xbox'].include?(platform)
        @user.platform = platform
        @user.save
        msg = 'Platform registered.'
      else
        msg = "Platform name invalid , options are: steam,ps,xbox"
      end
      send_message(msg)
    end

  end
end
