module DotenvSafe
  class Railtie < Rails::Railtie
    config.before_configuration { load }

    def load
      raise StandardError.new('I am an error')
    end
  end
end
