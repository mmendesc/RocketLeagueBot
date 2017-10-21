module BotCommand
  class MessageAll < Base

    def message_all
      @message.slice!("/#{Figaro.env.message_all} ")
      @message.slice!("/#{Figaro.env.message_all}")
      User.where(found: true).each do |user|
        BotCommand::Report.new(user,message).report
      end
    end
  end
end
