# frozen_string_literal: true

require_relative "newsconverter/version"
require_relative "services/convert_service"

module Newsconverter
  class Error < StandardError; end

  def self.run(path, format = nil, output = nil)
    converter = ConvertService.new(format)
    converter.load(path)
    converter.save(output)
  end
end
