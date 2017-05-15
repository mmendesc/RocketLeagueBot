class Rank < ApplicationRecord
  belongs_to :user


  def to_hash
    rank = Hash.new
    fields = ['playlist','rank','division','rating','division_up','division_down','games']
  end
end
