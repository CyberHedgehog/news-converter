# frozen_string_literal: true

require 'rss'

module Parsers
  class RssParser
    def self.can_parse?(format)
      format == 'rss'
    end

    def self.parse(data)
      parsed_data = RSS::Parser.parse(data)
      channel = {
        link: parsed_data.channel.link,
        title: parsed_data.channel.title,
        description: parsed_data.channel.description,
        items: []
      }
      parsed_data.items.each do |item|
        channel[:items] << {
          guid: item.guid.content,
          title: item.title,
          link: item.link,
          description: item.description,
          author: item.author,
          pubDate: item.pubDate,
          enclosure: item.enclosure.url,
          category: item.category
        }
      end
      return channel
    end
  end
end