ruby File.read('.ruby-version').chomp
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
source 'https://rubygems.org'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'dotenv-rails'
gem 'httparty'
gem 'lograge'
gem 'omniauth'
gem 'omniauth-spotify'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'sass-rails', '>= 6'
gem 'sentry-raven'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'webdrivers'
  gem 'webmock'
end

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.5'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

