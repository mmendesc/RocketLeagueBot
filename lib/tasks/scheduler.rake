require './lib/scraper_api/scraper'
require './lib/scraper_api/parser'
require './app/models/message_formatter'


  desc 'update status of all users'
  task :update_stats => :environment do
    @users = User.where(found: true, report: true).where.not(player_id: nil).where.not(platform: nil)
    @users.each do |user|
     # msg = 'We are back , everything is working now, you should get your report tomorrow. Thanks for the patience.'

     # BotCommand::Report.new(user,msg).report
     # BotCommand::Report.new(user,msg).report_sticker

      before = user.last_stat
      before_r = user.last_rank
      parser = ScraperApi::Scraper.new(user).get_page
      stats = ScraperApi::Scraper.new(user).stats(parser)
      ranks = ScraperApi::Scraper.new(user).divisions(parser)
      if !stats.blank? && false
        stats = stats.to_stats

        if user.played_today?(Stat.build_from_hash(user,stats),Rank.build_from_hash(user,ranks))
          user.add_stats(stats)
          user.add_rank(ranks)
        end

        after = user.last_stat
        after_r = user.last_rank

        if user.stats.size >= 2 && !before.nil?
          report = Stat.compare_stats(before,after)
          msg = MessageFormatter.new(report).report_stat
          BotCommand::Report.new(user,msg).report

          report = Rank.compare_rank(before_r,after_r)
          msg = MessageFormatter.new(report).report_rank
          BotCommand::Report.new(user,msg).report_html
        elsif user.stats.size == 1 && user.last_version == 1
          msg = 'Daily Report: We need more data, play one more day and you will receive your actual first report.'
          BotCommand::Report.new(user,msg).report
        else
          msg = "You didn't play in the last 24 hours."
          BotCommand::Report.new(user,msg).report
        end
      end
    end
  end

  desc 'check if user is findable'
  task :find_user => :environment do
    @users = User.where(found: true)
    @users.each do |user|
      unless !user.valid_for_search? || (user.last_stat.player_id == user.player_id && user.last_stat.platform == user.platform)
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


  desc 'delete older versions of users stats/ranks'
  task :clear_data => :environment do
    User.all.each do |user|
      version = user.last_version

      user.ranks.each do |rank|
        if rank.version != version
          rank.destroy
        end
      end

      user.stats.each do |stat|
        if stat.version != version
          stat.destroy
        end
      end
    end
  end
