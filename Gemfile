source "http://rubygems.org"

gemspec

mongoid_version = ENV["MONGOID_VERSION"] || "7.0.0"

gem "rake"
gem "mongoid", "~> #{mongoid_version}"
gem "request_store", require: false

group :development do
  gem "simplecov", require: false
  gem "pry-nav", "~> 0.2.4"
  gem "standard", "~> 0.1.0"
  gem "rubocop"
  gem "rubocop-performance"
end
