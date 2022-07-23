# fronzen_string_literal: true

Dir[File.dirname(__FILE__) + '/converters/*.rb'].each {|file| require file }

class Converter
  def initialize(format)
    Converters.constants.each do |converter_name|
      converter = Object.const_get "Converters::#{converter_name}"
      if converter.can_convert?(format)
        @converter = converter
      end
    end
  end

  def convert(data)
    @converter.convert(data)
  end
end