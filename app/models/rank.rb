class Rank < ApplicationRecord
  belongs_to :user


  def to_hash
    ranks = Hash.new
    fields = ['playlist','rank','division','rating','division_up','division_down','games']

    fields.each do |field|
      ranks[field] = self.send(field)
    end
  end

  def self.create_from_hash(user,ranks)
    ranks.each do |rank|
      user.ranks << Rank.new(playlist: rank['Playlist'], rank: rank['Rank'],division: rank['Division'],rating: rank['Rating'].delete(','), division_up: rank['DivUp'],division_down: rank['DivDown'],games: rank['Games'],
        version: user.last_version, player_id: user.player_id)
    end
  end


  def self.compare_rank(before,after)
    ranks = Array.new
    after.each do |a_rank|
      unless before.find_by_playlist(a_rank['playlist']).nil?
        rank = Hash.new
        b_rank = before.find_by_playlist(a_rank['playlist'])

        rank['playlist'] = a_rank['playlist']
        rank['rating'] = a_rank['rating'] - b_rank['rating']
        rank['games'] = a_rank['games'] - b_rank['games']
        rank['from'] = b_rank['rank'] + ' ' + b_rank['division']
        rank['to'] = a_rank['rank'] + ' ' + a_rank['division']

        ranks << rank
      end
    end
    ranks
  end

end
