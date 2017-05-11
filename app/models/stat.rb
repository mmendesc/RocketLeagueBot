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
    Stat.new(wins: stats['wins'],goals: stats['goals'],goal_ratio: stats['goal_ratio'],saves: stats['saves'],
            shots: stats['shots'],assists: stats['assists'],mvps: stats['mvps'], version: user.next_version,played: true)
  end

end
