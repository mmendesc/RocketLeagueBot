module BotCommand
  class MessageAll < Base

    def message_all
      @user.set_next_bot_command('BotCommand::MessageAll','send_to_all')
      @user.save
      send_message 'Type the message to send to all.'
    end

    def send_to_all
      # @message.slice!("/#{Figaro.env.message_all} ")
      # @message.slice!("/#{Figaro.env.message_all}")
      # User.where(found: true).each do |user|
      #   BotCommand::Report.new(user,message).report
      #   user.reset_next_bot_command
      # end
      # @user.reset_next_bot_command
    end
  end
end
