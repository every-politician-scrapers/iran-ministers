#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('.name').text.tidy
    end

    def position
      noko.css('.title').text.tidy
    end
  end

  class Members
    def members
      [president] + super
    end

    def president_node
      noko.css('.president')
    end

    def president
      {
        name:     president_node.css('h2').text.tidy,
        position: president_node.css('h3').text.tidy,
      }
    end

    def member_container
      noko.css('.minister,.vice_president').css('.col-lg-12')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
