require 'rugged'
include Rugged

module Broggle
  class Broggle < ActiveRecord::Base
    def repo
      @repo ||= Repository.discover(git_path)
    end
  end
end
