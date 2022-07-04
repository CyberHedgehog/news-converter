# frozen_string_literal: true

require 'json'

module Converters
  class JSONConverter
    def self.convert(data)
      data.to_json
    end
  end
end