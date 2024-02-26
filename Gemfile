source "https://rubygems.org"

ruby "3.2.2"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", ">= 4.0.1"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

gem "tailwindcss-rails"
gem "metainspector", "~> 5.15"
gem "passwordless", "~> 1.4"

gem "sqlite3", "~> 1.4"
gem "litestack", "~> 0.4.3"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "web-console"
  gem "letter_opener", "~> 1.9"
end

group :test do
  gem "capybara"
  gem "cuprite"
  gem "vcr", "~> 6.2"
  gem "webmock", "~> 3.22"
end
