source 'https://rubygems.org'

ruby '2.3.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.3'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# gem 'coffee-rails', '~> 4.2'
# gem 'therubyracer', platforms: :ruby
# gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'enumerize'
gem 'pundit'

# Jobs
gem 'redis', '~> 3.0'
gem 'sidekiq'
gem 'redcarpet', '~> 3.4.0'

# Theme
gem 'bootstrap3-rails'
gem 'font-awesome-rails'
gem 'bower-rails', '~> 0.11.0'

# Plataformatec
gem 'devise'
gem 'simple_form'
gem 'responders'

# Pagination
gem 'kaminari'
gem 'bootstrap-kaminari-views'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'rspec-expectations'
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
