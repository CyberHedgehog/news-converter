# frozen_string_literal: true

module Parsers
  class JSONParser
    def self.can_parse?(format)
      format == 'json'
    end

    def self.parse(data)
      JSON.parse(data)
    end
  end
end
