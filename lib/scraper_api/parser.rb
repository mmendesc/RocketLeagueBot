
module ScraperApi
  class Parser

    def initialize(body)
      @body = body
    end

    def goals
      get_stat('Goals')
    end

    def wins
      get_stat('Wins')
    end

    def goal_ratio
      get_stat('GoalShotRatio')
    end

    def saves
      get_stat('Saves')
    end

    def shots
      get_stat('Shots')
    end

    def mvps
      get_stat('MVPs')
    end

    def assists
      get_stat('Assists')
    end

    def get_stat(stat)
        data = @body.search('.stat')
        data.each do |x|
          if x.at('.value')['data-stat'] == stat
            stats = x.at('.value').text.strip
            return stats
          end
        end

    end

    def get_division
      information = ['Playlist','DivDown','Rating','DivUp','Games','Rank','Division']
      table=@body.search('#season-4.season-table')
      tbody=table.at('tbody')
      trs = tbody.css('tr')
      index = 1..5
      divisions = Array.new

      trs.each do |tr|
        tds=tr.css('td')
        divs = Hash.new
        tds[index].each_with_index do |td,i|
          if i ==0
            divs[information[5]] = td.at('small').text.strip.split(/[\r\n]+/).first.strip
            divs[information[6]] = td.at('small').text.strip.split(/[\r\n]+/).second.strip
          end
          divs[information[i]] = td.text.strip.split(/[\r\n]+/).first
        end
        unless divs['Rank'] == 'Unranked'
          divisions << divs
        end
      end
      divisions
    end

    def found_user?
      if @body.search('.alert.alert-danger.alert-dismissable').empty?
        stats = true
      else
        stats = false
      end
        stats

    end

  end
end
