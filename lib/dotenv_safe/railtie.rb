require 'pry'

module DotenvSafe
  class Railtie < Rails::Railtie
    config.before_configuration do
      check_env_vars
    end

    def check_env_vars
      binding.pry
      raise StandardError.new('I am an error')
    end
  end
end
