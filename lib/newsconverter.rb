# frozen_string_literal: true

require_relative 'newsconverter/version'
require_relative 'services/convert_service'

module Newsconverter
  class Error < StandardError; end

  def self.run(path, output, input_format, output_format, author = nil, sort = nil, limit = nil)
    converter = ConvertService.new(input_format, output_format)
    converter.load(path)
    converter.parse
    converter.filter(author) unless author.nil?
    converter.sort(sort) unless sort.nil?
    converter.limit(limit) unless limit.nil?
    converter.save(output)
  end
end
