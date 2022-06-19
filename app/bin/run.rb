#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

program :name, 'news-converter'
program :version, '0.0.1'
program :description, 'Parsig news'

command :convert do |c|
  c.syntax = 'syntax'
  c.description = 'Description'
  c.option '--input STRING', String, 'input target'
  c.option '--output STRING', String, 'output file'
  c.action do |args, options|
    say 'converting...'
  end
end

default_command :convert