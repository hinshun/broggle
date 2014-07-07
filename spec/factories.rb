# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :broggle, class: Broggle::Broggle do
    git_path 'spec/dummy-git'
  end

  factory :branch, class: Broggle::Branch do
  end
end
