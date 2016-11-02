# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dotenv_safe/version'

Gem::Specification.new do |spec|
  spec.name          = "dotenv_safe"
  spec.version       = DotenvSafe::VERSION
  spec.authors       = ["Ricardo Quiñones"]
  spec.email         = ["ricardo.quinones@wework.com"]

  spec.summary       = %q{Safe guarding deploys and builds without required environment variables}
  spec.description   = %q{
    Allows for specifying an .env.example file to check against for required environment variables
    in a rails app.
  }
  spec.homepage      = "https://github/wework/dotenv_safe"
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.2.2'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dotenv-rails", '~> 2.1.1'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rails", "~> 4.0"
  spec.add_development_dependency "pry"
end
