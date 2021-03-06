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
      msg = 'Type the platform you play.'
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
        send_message(msg)
      else
        msg = "Platform name invalid , options are: steam,ps,xbox."
        send_message(msg)
      end
      if @user.valid_for_search?
        parser = ScraperApi::Scraper.new(@user).get_page
        if parser.found_user?
          user.found = true
          user.save
        else
          user.found = false
          user.save
        end
      end

    end

  end
end
