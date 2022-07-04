# frozen_string_literal: true

require 'rss'

module Converters
  class RSSConverter
    def self.convert(data)
      rss = RSS::Maker.make('2.0') do |maker|
        maker.channel.link = data[:link]
        maker.channel.description = data[:description]
        maker.channel.title = data[:title]
        data[:items].each do |item|
          maker.items.new_item do |i|
            i.title = item[:title]
            i.link = item[:link]
            i.description = item[:description]
            i.author = item[:author]
            i.pubDate = item[:pubDate]
          end
        end
      end

      rss.to_xml
    end
  end
end
