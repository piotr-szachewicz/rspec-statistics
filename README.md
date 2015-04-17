# RSpec::Statistics [![Build Status](https://travis-ci.org/piotr-szachewicz/rspec-statistics.svg?branch=master)](https://travis-ci.org/piotr-szachewicz/rspec-statistics)

This Ruby gem gathers statistics about your RSpec tests.

For each example it records the following data:
 * how much time did that example take,
 * how many database queries were made and how much time they took,
 * how many request were made and how much time did they take.

This gem uses code from the [Profiling Your RSpec
Suite excellent article](http://www.foraker.com/profiling-your-rspec-suite/) by Ben Eddy.

It turns out that he already a gem (https://github.com/foraker/rspec_profiling) from his code,
so further development of `rspec-statistics` doesn't have much sense. But it was fun, anyway ;)

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


