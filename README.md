# RSpec::Statistics [![Build Status](https://travis-ci.org/piotr-szachewicz/rspec-statistics.svg?branch=master)](https://travis-ci.org/piotr-szachewicz/rspec-statistics)

This Ruby gem gathers statistics about your RSpec tests.

For each example it records the following data:
 * how much time did that example take,
 * how many database queries were made and how much time they took,
 * how many request were made and how much time did they take.

This gem uses code from the [Profiling Your RSpec
Suite excellent article](http://www.foraker.com/profiling-your-rspec-suite/) by Ben Eddy.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-statistics'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-statistics

## Usage

To gather the statistics you only need to add

```ruby
require 'rspec/statistics'
```

in your `spec_helper`.

After adding the above line, the statistics will be exported to the
`spec_profiles.csv` file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/piotr-szachewicz/rspec-statistics/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

