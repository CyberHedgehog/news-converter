# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'newsconverter'

require 'minitest/autorun'
require 'webmock/minitest'

def load_fixture(path)
  File.read(path)
end
