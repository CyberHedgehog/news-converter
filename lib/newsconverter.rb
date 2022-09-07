# frozen_string_literal: true

require_relative 'services/convert_service'

module Newsconverter
  class Error < StandardError; end

  def self.run(input_path, output_path, options)
    converter = ConvertService.new(options[:input], options[:output])
    author, sort, limit = options.values_at(:author, :sort, :limit)
    converter.load(input_path)
    converter.parse
    converter.filter(author) unless author.nil?
    converter.sort(sort) unless sort.nil?
    converter.limit(limit) unless limit.nil?
    converter.save(output_path)
  end
end
