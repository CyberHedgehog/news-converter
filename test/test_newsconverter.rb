# frozen_string_literal: true

require 'test_helper'

class TestNewsconverter < Minitest::Test
  def setup
    @output_dir = Dir.mktmpdir
  end

  def test_that_it_has_a_version_number
    refute_nil ::Newsconverter::VERSION
  end

  def test_convert_to_json_from_rss_file
    output_name = File.join(@output_dir, 'result.json')

    Newsconverter.run('test/fixtures/rss', output_name, 'rss', 'json')

    fixture_data = File.read('test/fixtures/result.json')
    result_data = File.read(output_name)

    assert_equal fixture_data, result_data
  end

  def test_filter
    output_name = File.join(@output_dir, 'result.json')

    Newsconverter.run('test/fixtures/rss', output_name, 'rss', 'json', 'Олег Давыдов')

    fixture_data = File.read('test/fixtures/result_filtered.json')
    result_data = File.read(output_name)

    assert_equal fixture_data, result_data
  end

  def test_sort
    output_name = File.join(@output_dir, 'result.json')

    Newsconverter.run('test/fixtures/rss', output_name, 'rss', 'json', nil, 'asc')

    fixture_data = File.read('test/fixtures/result_sorted.json')
    result_data = File.read(output_name)

    assert_equal fixture_data, result_data
  end
end
