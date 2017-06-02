class Stat < ApplicationRecord
  belongs_to :user

  def to_hash
    stats = Hash.new
    fields = ['goals','wins','goal_ratio','saves','shots','mvps','assists']

    fields.each do |field|
      stats[field] = self.send(field)
    end
    stats
  end

  def self.create_from_hash(user,stats)
    Stat.new(wins: stats['wins'].delete(','),goals: stats['goals'].delete(','),goal_ratio: stats['goal_ratio'],saves: stats['saves'].delete(','),
            shots: stats['shots'].delete(','),assists: stats['assists'].delete(','),mvps: stats['mvps'].delete(','), version: user.next_version,played: true,player_id: user.player_id,platform: user.platform)
  end

  def self.compare_stats(before,after)
    stats = Hash.new
    fields = ['goals','wins','goal_ratio','saves','shots','mvps','assists']
    fields.each do |field|
      stats[field] = after[field] - before[field]
    end
    stats
  end

end
