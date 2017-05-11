require './lib/scraper_api/scraper'
require './lib/scraper_api/parser'

namespace :users do

  desc 'update status of all users'
  task :update => :environment do
    @users = User.all
    @users.each do |user|
      if !user.chat_id.blank? && user.report
        BotCommand::Stats.new(user).stats
        BotCommand::Divisions.new(user).divisions
      end

      if user.valid_for_search?
        before= user.last_stat
        stats = ScraperApi::Scraper.new(user).stats

        if !stats.blank?
          stats = stats.to_stats

          user.add_stats(stats)


          after = user.last_stat

          if user.stats.size >= 2 && !before.nil?
            report = Stat.compare_stats(before,after)
            msg = MessageFormatter.new(report).report_stat
            BotCommand::Report.new(user,msg).report
          end
        end
      end
    end
  end
end
