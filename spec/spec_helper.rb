$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'pry'
require 'rails'
require 'coveralls'
Coveralls.wear!
require 'dotenv-rails-safe'
