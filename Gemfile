source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'by_star', '~> 3.0'
gem 'devise_token_auth'
gem 'dotenv-rails'
gem 'faker'
gem 'figaro'
gem 'fuubar'
gem 'jbuilder', '~> 2.5'
gem 'jwt'
gem 'oj'
gem 'omniauth'
gem 'pg', '~> 0.18'
gem 'premailer-rails'
gem 'puma', '~> 3.7'
gem 'rack-cors'
gem 'rack-rewrite'
gem 'rails', '~> 5.1.1'
gem 'simplecov', :require => false, :group => :test
gem 'will_paginate', '3.1.5'
gem 'yajl-ruby', require: 'yajl'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7'
end

group :test do

  gem 'airborne'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'minitest-reporters', '1.1.16'
  gem 'shoulda'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '3.5.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "capistrano", "~> 3.10"
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


