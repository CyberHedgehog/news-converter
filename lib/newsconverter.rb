# frozen_string_literal: true

require_relative "newsconverter/version"
require_relative 'services/load_service'

module Newsconverter
  class Error < StandardError; end

  def self.run(path, options)
    LoadService.load(path)
  end
end
