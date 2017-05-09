module BotCommand
  class Update < Base
    def update
      msg = switch_status
      send_message(msg)
      user.reset_next_bot_command
    end

    def switch_status
      if user.report == false || user.report.blank?
      user.report = true
      msg = 'Daily updates are on'
    else
      user.report = false
      msg = 'Daily updates are off'
    end
    user.save
    msg
    end
  end
end
