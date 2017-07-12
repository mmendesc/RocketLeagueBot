
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
      div=@body.search('#season-5.season-table')
      table = div.css('table').last
      tbody=table.at('tbody')
      trs = tbody.css('tr')
      index = 1..5
      divisions = Array.new
      trs.each do |tr|
        tds=tr.css('td')
        divs = Hash.new
        tds[index].each_with_index do |td,i|
          if i ==0
            str = td.at('small').text.split(/[\r\n]+/).second.strip
            str1 = td.at('small').text.split(/[\r\n]+/).third.strip
            divs[information[6]] = str
            divs[information[5]] = str1
          end

          divs[information[i]] = td.text.strip.split(/[\r\n]+/).first
        end
        unless divs['Rank'] == 'Unranked'
          divisions << divs
        end
      end
      divisions
    end

    def split_index(str)
      str.index('Bronze') || str.index('Silver') || str.index('Gold') || str.index('Platinum') || str.index('Diamond') || str.index('Champion') || str.index('Grand Champion') || str.index('Unranked')

    end

    def found_user?
      if @body == 'Invalid name.'
        stats = false
      else
        if @body.search('.alert.alert-danger.alert-dismissable').empty?
          stats = true
        else
          stats = false
        end
      end
      stats
    end

  end
end
