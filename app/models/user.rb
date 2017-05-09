class User < ApplicationRecord
  validates_uniqueness_of :telegram_id

  def set_next_bot_command(command)
    self.bot_command['command'] = command
    save
  end

  def get_next_bot_command
    bot_command['command']
  end

  def reset_next_bot_command
    self.bot_command = {}
    save
  end

  def valid_for_search?
    player_id.present? && platform.present?
  end

end
