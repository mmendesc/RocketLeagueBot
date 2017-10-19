class User < ApplicationRecord
  has_many :stats
  has_many :ranks
  validates_uniqueness_of :telegram_id

  scope :found, -> { where(found: true)}

  def set_next_bot_command(command,method)
    self.bot_command['command'] = command
    self.bot_command['method'] = method
    save
  end

  def get_next_bot_command
    bot_command['command']
  end

  def get_command_method
    bot_command['method']
  end

  def reset_next_bot_command
    unless self.bot_command.blank?
      self.bot_command = {}
      save
    end
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
    stat = self.stat(self.last_version)
    stat.nil? ? Stat.new : stat
  end

  def add_stats(stats)
    self.stats << Stat.create_from_hash(self,stats)
    self.save
  end

  def add_rank(ranks)
    Rank.create_from_hash(self,ranks)
  end

  def last_rank
    self.rank(self.last_version)
  end

  def rank(version)
    self.ranks.where(version: version)
  end

  def found?
    found
  end

end
