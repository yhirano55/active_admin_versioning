source 'https://rubygems.org'

gemspec

gem "rails",       "5.0.7"
gem "paper_trail", "~> 5.2.2"
gem "inherited_resources", github: "activeadmin/inherited_resources"
gem "activeadmin",         github: "activeadmin/activeadmin"
gem "pry"
gem 'appraisal'

group :development do
  gem "rubocop", "~> 0.40.0"
end

group :test do
  gem "capybara"
  gem "rspec-rails"
  gem "database_cleaner"
  gem 'shoulda-matchers'
  gem "sqlite3", platforms: :mri
  gem "poltergeist"
end
