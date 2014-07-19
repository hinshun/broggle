module RuggedSpecHelper
  module_function

  require 'rspec/mocks/standalone'

  WORK_DIR = Broggle::Engine.root.join("spec/dummy-git/")
  BROGGLER = { name: "Broggle", email: "" }
  BASE_COMMIT_OPTIONS = {
    author: BROGGLER,
    commiter: BROGGLER,
    update_ref: 'HEAD'
  }
  GIT_FILEMODE_BLOB = 0100644

  mattr_accessor :current_branch

  def repo
    @repo ||= Rugged::Repository.new(WORK_DIR.to_s)
  end

  def prepare_repo
    stub_const "Broggle::Broggle::GIT_PATH", WORK_DIR.to_s

    if Dir.exists? WORK_DIR
      FileUtils.rm_r Dir.glob(WORK_DIR.join('*'))

      git_dir = WORK_DIR.join '.git'
      FileUtils.rm_rf git_dir if Dir.exists? git_dir
    else
      FileUtils.mkdir WORK_DIR
    end

    new_repo = Rugged::Repository.init_at(WORK_DIR.to_s)

    index = new_repo.index
    commit(new_repo, index.write_tree(new_repo), 'Initial commit')
  end

  def create_scenario(scenario)
    case scenario
    when :no_conflict
      create_no_conflict_scenario
    when :conflict
      create_conflict_scenario
    end
  end

  def create_no_conflict_scenario
    repo.checkout('master')
    write_file_to_repo(repo, 'filename',  'content')

    self.current_branch = 'no_conflict_branch'
    repo.create_branch(current_branch)
    repo.checkout(current_branch)
    write_file_to_repo(repo, 'filename', 'new content')

    repo.checkout('master', strategy: :force)
  end

  def create_conflict_scenario
    repo.checkout('master')
    write_file_to_repo(repo, 'filename', 'content')

    self.current_branch = 'conflict_branch'
    repo.create_branch(current_branch)
    repo.checkout(current_branch)
    write_file_to_repo(repo, 'filename', 'new content')

    repo.checkout('master', strategy: :force)
    write_file_to_repo(repo, 'filename', 'conflict')
  end

  def write_file_to_repo(repo, filename, content)
    builder = Rugged::Tree::Builder.new
    builder << {
      type: :blob,
      name: filename,
      oid: repo.write(content, :blob),
      filemode: GIT_FILEMODE_BLOB
    }

    commit(repo, builder.write(repo), "Wrote #{content} to #{filename}")
  end

  def commit(repo, tree, message)
    commit_options = BASE_COMMIT_OPTIONS.merge(
      parents: repo.empty? ? [] : [repo.head.target].compact,
      tree: tree,
      message: message
    )

    Rugged::Commit.create(repo, commit_options)
  end
end
