require 'rugged'
require 'string_scorer'

module Broggle
  class Broggle < ActiveRecord::Base
    def deploy(branches)
      repo.checkout(branches)
    end

    def repo
      @repo ||= Rugged::Repository.discover('.')
    end

    def branches
      repo.branches
    end

    def current_branch_name
      repo.head.name.sub(/^refs\/heads\//, '')
    end

    def branches_substring_search(query)
      branches.select{ |b| b.name[/#{query}/] }
    end

    def branches_flex_search(query, limit)
      scored_branches = branches.map{ |b| { name: b.name, score: b.name.score(query) } }
        .select{ |b| b[:score] != 0  }
      scored_branches.take([limit, scored_branches.count].min)
    end
  end
end
