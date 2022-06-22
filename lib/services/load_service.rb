# frozen_string_literal: true

require 'loaders/file_loader'

class LoadService
  def self.load(path)
    Loaders::FileLoader.load(path)
  end
end