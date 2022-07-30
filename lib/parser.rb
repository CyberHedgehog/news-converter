# frozen_string_literal: true

# fronzen_string_literal: true

Dir["#{File.dirname(__FILE__)}/parsers/*.rb"].sort.each { |file| require file }

class Parser
  def initialize(format)
    Parsers.constants.each do |parser_name|
      parser = Object.const_get "Parsers::#{parser_name}"
      @parser = parser if parser.can_parse?(format)
    end
  end

  def parse(data)
    @parser.parse(data)
  end
end
