module Broggle
  class Broggle < ActiveRecord::Base
    require 'rugged'
    require 'string_scorer'
    include Rugged

    GIT_PATH = '.'
    DOTFILE = '.broggle'
    DATE_FORMAT = '%Y%m%d%H%M%S'
    BROGGLER = { name: "Broggle", email: "" }
    BASE_COMMIT_OPTIONS = {
      author: BROGGLER,
      commiter: BROGGLER,
      update_ref: 'HEAD'
    }

    def repo
      @repo ||= Repository.discover(GIT_PATH)
    end

    def branches
      repo.branches.reject { |branch| branch.name.start_with?('broggle_') }
    end

    def current_branch
      repo.head.name.sub(/^refs\/heads\//, '')
    end

    def deploy(branches)
      create_broggle(branches.fetch(:base))
      repo.checkout(@broggle_branch)

      branches.fetch(:merges).each { |branch| merge(branch) }
    end

    def create_broggle(base_branch)
      repo.checkout(base_branch)

      @broggle_branch = "broggle_#{Time.now.strftime(DATE_FORMAT)}"
      repo.create_branch(@broggle_branch)
    end

    def merge(branch)
      broggle_commit = repo.branches[@broggle_branch].target
      branch_commit = repo.branches[branch].target

      index = repo.merge_commits(broggle_commit, branch_commit)
      return :merge_conflict if index.conflicts?

      commit_options = BASE_COMMIT_OPTIONS.merge(
        parents: [broggle_commit, branch_commit],
        tree: index.write_tree(repo),
        message: "Merge branch `#{branch}` into #{@broggle_branch}"
      )

      Rugged::Commit.create(repo, commit_options)

      :merge_success
    end

    def branches_substring_search(query, limit = Float::INFINITY)
      matched_branches = branches.select { |b| b.name[/#{query}/] }.map(&:name)
      matched_branches.take([limit, matched_branches.count].min)
    end

    def branches_flex_score(query, limit = Float::INFINITY)
      matched_branches = branches.map { |b| { name: b.name, score: b.name.score(query) } }
        .select { |b| b.fetch(:score) != 0  }
      matched_branches.take([limit, matched_branches.count].min)
    end
  end
end
