require 'httparty'
require 'uri'
#require 'nokogiri'

module ScraperApi
  class Scraper
    include HTTParty

    attr_reader :bot


    def initialize(user,bot=nil)
      @base_uri = 'https://rocketleague.tracker.network/profile/'
      @user = user
      @bot = bot
      @stats = Hash.new
    end


    def goals
      get_stat('goals')
    end


    def wins
      get_stat('wins')
    end

    def goal_ratio
      get_stat('goal_ratio')
    end

    def saves
      get_stat 'saves'
    end

    def shots
      get_stat 'shots'
    end

    def mvps
      get_stat 'mvps'
    end

    def assists
      get_stat 'assists'
    end

    def stats(parser = nil)
      if @user.found
        if parser.nil?
          parser = get_page
        end

        @user.found = true
        @user.save
        stats = ['goals','wins','goal_ratio','saves','shots','mvps','assists']
        stats.each do |stat|
          @stats[stat] = get_stat(stat,parser)
        end

      else
        @stats = 'not found'
      end
      @stats
    end



    def full_uri
      "#{@base_uri}#{@user.platform}/#{@user.player_id}"
    end

    def get_page
      puts full_uri
      begin
        uri = URI.parse(full_uri)
        response = HTTParty.get(full_uri)
        parsed_response= Nokogiri::HTML(response.body)
        ScraperApi::Parser.new(parsed_response)
      rescue URI::InvalidURIError
        ScraperApi::Parser.new('Invalid name.')
      end

    end

    def get_stat(stat,parser)
        stat_parser = parser
        stats=stat_parser.send(stat)
    end

    def divisions(parser = nil)
      if @user.found
        if parser.nil?
          parser = get_page
        end
        divisions = parser.get_division
      else
        divisions = 'N'
      end
    end



  end
end
