# frozen_string_literal: true
require 'rss'

module Converters
  class AtomConverter
    def self.can_convert?(format)
      format == 'atom'
    end

    def self.convert(data)
      result = RSS::Maker.make('atom') do |maker|
        maker.channel.id = data[:link]
        maker.channel.updated = Time.now.to_s
        maker.channel.link = data[:link]
        maker.channel.description = data[:description]
        maker.channel.title = data[:title]
        data[:items].each do |item|
          maker.items.new_item do |i|
            i.author = item[:author] || ''
            i.title = item[:title]
            i.link = item[:link]
            i.description = item[:description]
            i.pubDate = item[:pubDate]
          end
        end
      end

      result.to_xml
    end
  end
end