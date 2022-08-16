# frozen_string_literal: true

require_relative '../converter'
require_relative '../parser'
require 'open-uri'

class ConvertService
  def initialize(input_format = 'json', output_format = 'json')
    @parser = Parser.new(input_format)
    @converter = Converter.new(output_format)
  end

  def load(path)
    @raw_data = if URI.parse(path).host
                  URI.parse(path).open.read
                else
                  File.read(path)
                end
  end

  def parse
    @data = @parser.parse @raw_data
  end

  def filter(author)
    @data[:items].filter! { |item| item[:author] == author }
  end

  def sort(direction)
    @data[:items].sort! do |a, b|
      a_date = a[:pubDate]
      b_date = b[:pubDate]
      if direction == 'desc'
        b_date <=> a_date
      else
        a_date <=> b_date
      end
    end
  end

  def limit(number)
    @data[:items] = @data[:items].take number
  end

  def save(path = 'json')
    data = @converter.convert(@data)
    File.write(path, data)
  end
end
