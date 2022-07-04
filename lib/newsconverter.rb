# frozen_string_literal: true

require_relative "newsconverter/version"
require_relative "services/convert_service"

module Newsconverter
  class Error < StandardError; end

  def self.run(path, options)
    converter = ConvertService.new(options.format)
    converter.load(path)
    converter.save(options.output)
  end
end
