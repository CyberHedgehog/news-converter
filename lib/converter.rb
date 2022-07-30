# frozen_string_literal: true

# fronzen_string_literal: true

Dir["#{File.dirname(__FILE__)}/converters/*.rb"].sort.each { |file| require file }

class Converter
  def initialize(format)
    Converters.constants.each do |converter_name|
      converter = Object.const_get "Converters::#{converter_name}"
      @converter = converter if converter.can_convert?(format)
    end
  end

  def convert(data)
    @converter.convert(data)
  end
end
