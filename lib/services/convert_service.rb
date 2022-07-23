# frozen_string_literal: true

require_relative '../parsers/rss_parser'
require_relative '../converter'
require 'open-uri'

class ConvertService
  def initialize(format = 'json')
    @converter = Converter.new(format)
  end

  def load(path)
    if URI.parse(path).host
      raw_data = URI.open(path).read
    else
      raw_data = File.read(path)
    end
    @data = Parsers::RssParser.parse raw_data
  end

  def save(path = 'json')
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