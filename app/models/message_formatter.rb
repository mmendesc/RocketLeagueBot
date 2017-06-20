class MessageFormatter

  def initialize(info=nil)
    @info = info
  end

  def self.instructions
    msg =
    "<b>Welcome to Rocket League Stats Bot </b>
    Data extracted from: <a href='https://rocketleague.tracker.network'>Rocket League Tracker</a>
    <pre>---------------------------------------------------</pre>
    <b>Instructions:</b>
    First set your user with /username
    Example: /username yournamegoeshere
    Second set the platform you play , options [steam,ps,xbox]
    Example: /platform steam
    <pre>---------------------------------------------------</pre>
    <b>Settings</b>
      /username  - Set your user username or id
      /platform  - Set your platform
      /update       - Set on/off daily stastics <b>default: on</b>
      /help         - Send bot command help
      /user         - Send name/platform you entered

    <b>Stats </b>
      /stats        - Send your statistics
      /rank    - Send your ranked statistics

    <pre>---------------------------------------------------</pre>
    <i> Created by Mmendesc </i>
    "

    msg
  end

  def self.help
    msg=
    "
    <b>Instructions:</b>
    First set your user with /username
    Second set the platform you play with /platform , options [steam,ps,xbox]

    <pre>---------------------------------------------------</pre>
    <b>Settings</b>
      /username  - Set your user username or id
      /platform  - Set your platform
      /update       - Set on/off daily stastics <b>default: on</b>
      /help         - Send bot command help
      /user         - Send name/platform you entered

    <b>Stats </b>
      /stats        - Send your statistics
      /rank    - Send your ranked statistics

    <pre>---------------------------------------------------</pre>
    <i> Created by Mmendesc </i>
    "

    msg
  end

  def stats
      if @info == 'not found'
        msg = 'User not found.'
      else
        msg =
            "
Wins: #{@info['wins']}
Goals: #{@info['goals']}
Goal/Shot ratio: #{@info['goal_ratio']}
Saves: #{@info['saves']}
Shots: #{@info['shots']}
Assists: #{@info['assists']}
MVPs: #{@info['mvps']}
            "
      end
    msg
  end

  def report_stat
    if self.not_played?
      msg = "You didn't play in the last 24 hours."
    else
      msg =
    "
This is your daily report.(still in beta)
To turn off daily updates, send /update

Report of your progression from last 24 hours:
Wins: #{@info['wins']}
Goals: #{@info['goals']}
Goal/Shot ratio: #{@info['goal_ratio']}
Saves: #{@info['saves']}
Shots: #{@info['shots']}
Assists: #{@info['assists']}
MVPs: #{@info['mvps']}
    "
    end
    msg
  end

  def ranks
    if @info == 'N'
        msg = 'User not found.'
      else
        msg = String.new
        @info.each do |info|
          unless info['Playlist'] == 'Un-Ranked'
            msg1 =
              "
Playlist: #{info['Playlist']}

  Rank: #{info['Rank']} #{info['Division']}
  Rating: #{info['Rating']}
  Division Up: #{info['DivUp']}
  Division Down: #{info['DivDown']}
  Games: #{info['Games']}

            "
            msg << msg1
          end

        end
        msg = msg.blank? ? "No ranked data found." : msg
      end

  end

  def self.compare_stats(before,after)
    stats = Hash.new
    fields = ['goals','wins','goal_ratio','saves','shots','mvps','assists']
    fields.each do |field|
      stats[field] = after[field] - before[field]
    end
    stats
  end

  def not_played?
    count = 0
    fields = ['goals','wins','goal_ratio','saves','shots','mvps','assists']
    fields.each do |field|
      count = @info[field] == 0 ? count + 1 : count
    end
    count == 7
  end

  def report_rank
    msg = 'Report of your progression from last 24 hours:'
    @info.each do |info|
      if info['games'] == 0
        msg += ""
      else
        if info['rating'] > 0
          resume = ['positive','+']
        elsif info['rating'] < 0
          resume = ['negative','']
        else
          resume = ['neutral','']
        end


        msg = msg+
          "
Playlist: <b>#{info['playlist']}</b>
  You had a #{resume[0]} result
  Rating: <b>#{resume[1]}#{info['rating']} </b>
  Current Rating: <b>#{info['current_rating']}</b>
  From: #{info['from']}
  To: #{info['to']}
  Games: #{info['games']}


            "


      end
    end
    msg = (msg == 'Report of your progression from last 24 hours:') ? '' : msg
  end

end

class Hash
  def to_stats
    stats = ['goals','wins','goal_ratio','saves','shots','mvps','assists']
    stats.each do |stat|
      if stats != 'goal_ratio'
        self[stat] = self[stat]
      else
        self[stat] = self[stat].to_d
      end
    end
    self
  end

  def compare_stats(before,after)
    stats = Hash.new
    fields = ['goals','wins','goal_ratio','saves','shots','mvps','assists']
    fields.each do |field|
      stats[field] = after[field] - before[field]
    end
    stats
  end
end
