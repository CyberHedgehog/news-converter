# frozen_string_literal: true

class Parsers::JSONParser
  def self.can_parse?(format)
    format == 'json'
  end

  def self.parse(data)
    JSON.parse(data)
  end
end

