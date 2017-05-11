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
            report = MessageFormatter.compare_stats(before,after)

            # options = {user_id: user.id, bot: bot, report: report}
            # MessageResponder.new(options).stat_report(options)
          end
        end
      end
    end
  end
end
