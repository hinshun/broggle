# Broggle

[![Build Status](https://travis-ci.org/hinshun/broggle.png?branch=master)](https://travis-ci.org/hinshun/broggle) [![Coverage Status](https://coveralls.io/repos/hinshun/broggle/badge.png)](https://coveralls.io/r/hinshun/broggle)

Broggle is a mountable rails engine that allows testers and QAs to quickly test
a multiple git branches of a Rails application. 

## Features

* Configure environments with different branches without affecting the currently
  running environment
* Toggle merged branches on/off with one click
* Stack traces integrated with changed lines from merged branches

## Installation

Note: Broggle is still in active development

Add this line to your application's Gemfile:

    gem 'broggle'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install broggle

## Usage

Mount Broggle to a route in your application's routes file:

    mount Broggle::Engine => "/broggle"

Done!

## Contributing

1. Fork it ( https://github.com/hinshun/broggle/fork )
2. Create your feature branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature-name`)
5. Create a new Pull Request

