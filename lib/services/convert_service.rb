# frozen_string_literal: true

require_relative '../parsers/rss_parser'
require_relative '../converters/json_converter'
require_relative '../converters/rss_converter'
require_relative '../converters/atom_converter'
require 'open-uri'

class ConvertService
  def initialize(format = 'json')
    case format
    when 'json'
      @converter = Converters::JSONConverter
    when 'rss'
      @converter = Converters::RSSConverter
    when 'atom'
      @converter = Converters::AtomConverter
    end
  end

  def load(path)
    if URI.parse(path).host
      raw_data = URI.open(path).read
    else
      raw_data = File.read(path)
    end
    @data = Parsers::RssParser.parse raw_data
  end

  def save(path)
    data = @converter.convert(@data)
    File.write(path, data)
  end

  private

  def to_json(data)
    data.to_json
  end

  def to_rss(data)

  end
end