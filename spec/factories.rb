# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :broggle, class: Broggle::Broggle do
  end

  factory :branch, class: Broggle::Branch do
  end
end
