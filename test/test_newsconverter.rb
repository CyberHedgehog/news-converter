# frozen_string_literal: true

require_relative './test_helper'

class TestNewsconverter < Minitest::Test
  def setup
    @output_dir = Dir.mktmpdir
  end

  def test_convert_to_json_from_rss_file
    output_name = File.join(@output_dir, 'result.json')

    options = { input: 'rss', output: 'json' }
    Newsconverter.run('test/fixtures/rss', output_name, options)

    fixture_data = File.read('test/fixtures/result.json')
    result_data = File.read(output_name)

    assert_equal fixture_data, result_data
  end

  def test_filter
    output_name = File.join(@output_dir, 'result.json')

    options = {
      input: 'rss',
      output: 'json',
      author: 'Олег Давыдов'
    }

    Newsconverter.run('test/fixtures/rss', output_name, options)

    fixture_data = File.read('test/fixtures/result_filtered.json')
    result_data = File.read(output_name)

    assert_equal fixture_data, result_data
  end

  def test_sort
    output_name = File.join(@output_dir, 'result.json')

    options = {
      input: 'rss',
      output: 'json',
      sort: 'asc'
    }

    Newsconverter.run('test/fixtures/rss', output_name, options)

    fixture_data = File.read('test/fixtures/result_sorted.json')
    result_data = File.read(output_name)

    assert_equal fixture_data, result_data
  end

  def test_limit
    output_name = File.join(@output_dir, 'result.json')

    options = {
      input: 'rss',
      output: 'json',
      sort: 'asc',
      limit: 2
    }
    Newsconverter.run('test/fixtures/rss', output_name, options)

    result_data = File.read(output_name)
    result = JSON.parse(result_data)
    assert_equal result['items'].length, options[:limit]
  end

  def test_download_from_web
    body = File.read('test/fixtures/rss')
    stub_request(:get, 'http://www.testnews.com/')
      .with(
        headers: {
          Accept: '*/*',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent': 'Ruby'
        }
      )
      .to_return(status: 200, body: body)

    output_name = File.join(@output_dir, 'result.json')

    options = {
      input: 'rss',
      output: 'json'
    }
    Newsconverter.run('http://www.testnews.com', output_name, options)

    fixture_data = File.read('test/fixtures/result.json')
    result_data = File.read(output_name)

    assert_equal fixture_data, result_data
  end
end
