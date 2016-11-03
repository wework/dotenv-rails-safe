`dotenv-rails-safe`
===================

[![Build Status][travis-image]][travis-url]
[![Coverage Status][coveralls-image]][coveralls-url]
[![MIT License][license-image]][license-url]

This gem is an extension of the [`dotenv`](https://github.com/bkeepers/dotenv) gem that ensures that required environment variables are set before deploying to production or running code locally. Required variables are read from `.env.example` and should be commited to source code. This is heavily inspired by [dotenv-safe](https://github.com/rolodato/dotenv-safe).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dotenv-rails-safe'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dotenv-rails-safe

## Example `.env.example`

```dosini
# .env.example, commited to repo
SECRET=
TOKEN=
MISSING_KEY=
ANOTHER_MISSING_KEY=
# Commented out keys are not required but these are good for documentation purposes
# KEY= 
```

```dosini
# .env
SECRET=topsecret
TOKEN=
```

Since the provided `.env` file does not contain all the variables defined in
`.env.example`, an exception is thrown:

```
Dotenv::MissingEnvVarError: Missing the following environment variables: MISSING_KEY and ANOTHER_MISSING_KEY
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wework/dotenv-rails-safe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[travis-image]: https://img.shields.io/travis/wework/dotenv-rails-safe.svg?branch=master
[travis-url]: https://travis-ci.org/wework/dotenv-rails-safe
[coveralls-image]: https://coveralls.io/repos/github/wework/dotenv-rails-safe/badge.svg?branch=test-travis
[coveralls-url]: https://img.shields.io/travis/wework/dotenv-rails-safe/master.svg
[license-url]: LICENSE
[license-image]: http://img.shields.io/badge/license-MIT-000000.svg?style=flat-square
