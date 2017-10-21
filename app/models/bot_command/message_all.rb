module BotCommand
  class MessageAll < Base

    def message_all
      @message.slice!("/#{Figaro.env.message_all} ")
      @message.slice!("/#{Figaro.env.message_all}")
      User.only_found.each do |user|
        BotCommand::Report.new(user,message).report
      end
    end
  end
end
