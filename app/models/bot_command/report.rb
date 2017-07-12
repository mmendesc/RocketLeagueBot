module BotCommand
  class Report < Base

    def report
      unless @message.nil? || @message.blank?
        send_message @message
      end
    end

    def report_html
      unless @message.nil? || @message.blank?
        send_html_message @message
      end
    end

    def report_all
      User.where(report: true,found: true).each do |user|
        BotCommand::Report.new(user,@message.split("/todos42")[1]).report
      end
    end

    def report_sticker
      send_sticker('CAADBAADOQADCc_9B9UIuGUWwg3DAg')
    end

  end
end
