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
      BotCommand::Start.new(user, message).start
    when /^\/help/
      BotCommand::Help.new(user,message).help
    when /^\/update/
      BotCommand::Update.new(user,message).update
    when /^\/nickname/
      BotCommand::Nickname.new(user,message).nickname
    when /^\/platform/
      BotCommand::Platform.new(user,message).platform
    when /^\/user/
      BotCommand::User.new(user,message).user
    else
      unknown_command
    end
  end

  private

  def unknown_command
    BotCommand::Undefined.new(user, message).start
  end
end
