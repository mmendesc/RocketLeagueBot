class BotMessageDispatcher
  attr_reader :message, :user

  def initialize(message, user)
    @message = message[:message][:text]
    @user = user

  end

  def process
    respond
  end

  def respond
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
    else
      unknown_command
    end
  end

  private

  def unknown_command
    BotCommand::Undefined.new(user, message).start
  end
end
