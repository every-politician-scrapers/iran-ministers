#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'نام'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[name constituency state party faction].freeze
    end

    def itemLabel
      super.gsub(/\(.*?\)/, '')
    end

    field :constituency do
      tds[columns.index('constituency')].css('a/@wikidata').text
    end

    def startDate
      '2020-05-27'
    end

    def endDate
      nil
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
