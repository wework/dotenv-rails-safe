$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'pry'
require 'dotenv_safe'
require 'rails'
require 'dotenv_safe/railtie' # explicit require for testing
