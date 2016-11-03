require 'dotenv-rails'

module Dotenv
  class MissingEnvVarError < StandardError; end

  class Railtie < Rails::Railtie
    config.before_configuration do
      # Make sure to force load environment variables for dotenv in development
      if Rails.env.development?
        Dotenv::Railtie.load
      end

      check_env_vars unless Rails.env.test?
    end

    def check_env_vars
      missing_env_vars = aggregate_missing_env_vars

      if missing_env_vars.any?
        raise MissingEnvVarError.new([
          'Missing the following environment variables: ',
          missing_env_vars.to_sentence
        ].join(''))
      end
    end

    private

    # Returns an array of missing environment variables
    #
    # @return [Array<String>]
    def aggregate_missing_env_vars
      example_env_vars.inject([]) do |array, key_and_value|
        key = key_and_value[0]

        begin
          ENV.fetch(key)
          array
        rescue KeyError
          array << key
        end
      end
    end

    # Returns a hash of environment variables defined in `.env.example`
    #
    # @return [Hash]
    def example_env_vars
      Parser.call(read)
    rescue Errno::ENOENT, FormatError
      {}
    end

    def read
      File.open(root.join('.env.example'), "rb:bom|utf-8", &:read)
    end

    def root
      Rails.root || Pathname.new(ENV["RAILS_ROOT"] || Dir.pwd)
    end
  end
end
