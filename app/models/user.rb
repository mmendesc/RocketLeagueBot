class User < ApplicationRecord
  has_many :stats
  has_many :ranks
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

  def last_version
    last = self.stats.last
    last.nil? ? 1 : last.version
  end

  def next_version
    last = self.stats.last
    last.nil? ? 1 : last.version + 1
  end

  def stat(version)
    self.stats.find_by_version(version)
  end

  def last_stat
    self.stat(self.last_version)
  end

  def add_stats(stats)
    self.stats << Stat.create_from_hash(self,stats)
    self.save
  end

  def found?
    found
  end

end
