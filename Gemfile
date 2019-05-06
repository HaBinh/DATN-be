source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'faker'
gem 'devise_token_auth'
gem 'omniauth'
gem 'rack-cors'
gem 'jwt'
gem 'rails', '~> 5.1.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'jbuilder', '~> 2.5'
gem 'dotenv-rails'
gem 'yajl-ruby', require: 'yajl'
gem 'oj'
gem 'fuubar'
gem 'rack-rewrite'
gem 'simplecov', :require => false, :group => :test
gem 'figaro'
gem 'will_paginate',           '3.1.5'
gem 'premailer-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.7'
end

group :test do
  
  gem 'shoulda'
  gem 'airborne'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
  gem 'minitest-reporters',       '1.1.16'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "capistrano", "~> 3.10"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


