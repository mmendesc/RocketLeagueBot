class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback

    dispatcher.new(webhook, user).process
    head :ok
  end

  def webhook
    params['webhook']
  end

  def dispatcher
    BotMessageDispatcher
  end

  def from
    webhook[:message][:from]
  end

  def chat
    webhook[:message][:chat]
  end

  def user
    @user ||= User.find_by(telegram_id: from[:id]) || register_user
  end

  def register_user
    @user = User.find_or_initialize_by(telegram_id: from[:id])
    @user.update_attributes!(first_name: from[:first_name], last_name: from[:last_name],chat_id: chat[:id])
    @user
  end

end
