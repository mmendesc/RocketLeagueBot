module BotCommand
  class Feedback < Base

    def feedback
      msg = 'Type in your suggestion/improvements you wanna see in this bot.'
      @user.set_next_bot_command('BotCommand::Feedback','save_feedback')
      @user.save
      send_message msg
    end

    def save_feedback
      @user.bot_command = {}
      @user.opinions.new(text: @message)
      @user.save
      send_message 'Thanks for the feedback.'
    end

  end
end
