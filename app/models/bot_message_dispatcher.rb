class BotMessageDispatcher
  attr_reader :message, :user

  def initialize(message, user)
    @message = message[:message][:text]
    @user = user
    @secret = Figaro.env.message_all
  end

  def process
    respond
  end

  def respond
    if !@user.bot_command.blank? && @message.try(:first) != '/'
      if @message.nil? || !@message.match(/[\u{1F600}-\u{1F6FF}]/).nil?
        msg = 'Try again.'
        BotCommand::Report.new(@user,msg).report
      else
        @user.get_next_bot_command.safe_constantize.new(user,message).send(@user.get_command_method)
      end
    else
      case @message
      when /^\/start/
        BotCommand::Start.new(user).start
      when /^\/help/
        BotCommand::Help.new(user).help
      when /^\/update/
        BotCommand::Update.new(user).update
      when /^\/username/
        BotCommand::Username.new(user,message).username
      when /^\/platform/
        BotCommand::Platform.new(user,message).platform
      when /^\/user/
        BotCommand::User.new(user).user
      when /^\/stats/
        BotCommand::Stats.new(user).stats
      when /^\/rank/
        BotCommand::Rank.new(user).rank
      when /^\/feedback/
        BotCommand::Feedback.new(user,message).feedback
      when /^\/#{Regexp.quote(@secret)}/
        BotCommand::MessageAll.new(user,message).message_all
      else
        unknown_command
      end
    end
  end

  private

  def unknown_command
    BotCommand::Undefined.new(user, message).start
  end
end
