require './lib/scraper_api/scraper'
require './lib/scraper_api/parser'
require './app/models/message_formatter'


desc 'update status of all users'
  task :update_stats => :environment do
    @users = User.all
    @users.each do |user|
      if user.found? && user.report
       # BotCommand::Report.new(user,'This is your daily report.(still in beta)').report
       # BotCommand::Report.new(user,'To turn off daily updates, send /update').report
        #BotCommand::Stats.new(user).stats
        #BotCommand::Rank.new(user).rank


        before = user.last_stat
        before_r = user.last_rank
        stats = ScraperApi::Scraper.new(user).stats
        ranks = ScraperApi::Scraper.new(user).divisions
        if !stats.blank?
          stats = stats.to_stats

          user.add_stats(stats)
          user.add_rank(ranks)

          after = user.last_stat
          after_r = user.last_rank
          if user.stats.size >= 2 && !before.nil?
            report = Stat.compare_stats(before,after)
            msg = MessageFormatter.new(report).report_stat
            #BotCommand::Report.new(user,msg).report

            report = Rank.compare_rank(before_r,after_r)
            msg = MessageFormatter.new(report).report_rank
            #BotCommand::Report.new(user,msg).report
          end
        end
      end
    end
  end
