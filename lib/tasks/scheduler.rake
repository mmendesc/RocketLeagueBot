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
        parser = ScraperApi::Scraper.new(user).get_page
        stats = ScraperApi::Scraper.new(user).stats(parser)
        ranks = ScraperApi::Scraper.new(user).divisions(parser)
        if !stats.blank?
          stats = stats.to_stats

          user.add_stats(stats)
          user.add_rank(ranks)

          after = user.last_stat
          after_r = user.last_rank

          if user.stats.size >= 2 && !before.nil?
            report = Stat.compare_stats(before,after)
            msg = MessageFormatter.new(report).report_stat
            BotCommand::Report.new(user,msg).report

            report = Rank.compare_rank(before_r,after_r)
            msg = MessageFormatter.new(report).report_rank
            BotCommand::Report.new(user,msg).report_html
          elsif user.stats.size == 1
            msg = 'Daily Report: We need more data, tomorrow you will receive your actual first report.'
            BotCommand::Report.new(user,msg).report
          end
        end
      end
    end
  end

desc 'check if user is findable'
  task :find_user => :environment do
    @users = User.all
    @users.each do |user|
      unless !user.valid_for_search? || (user.found? && (user.last_stat.player_id == user.player_id && user.last_stat.platform == user.platform))
        parser = ScraperApi::Scraper.new(user).get_page
        if parser.found_user?
          user.found = true
          user.save
        else
          user.found = false
          user.save
        end
      end
    end
  end
