# this_town

`this_town` is a RubyGem generator for Sinatra applications that use the
following libraries:

* database: [sequel](http://sequel.rubyforge.org/)
* templates: [mustache](https://github.com/defunkt/mustache)
* testing: [test-unit](http://test-unit.rubyforge.org/) and [rack-test](https://github.com/brynary/rack-test)
* mocking: [mocha](http://gofreerange.com/mocha/docs/)
* automation: [guard](https://github.com/guard/guard)

## Installation

Add this line to your application's Gemfile:

    gem 'this_town'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install this_town

## Usage

    this_town foo # Generates project called foo

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
