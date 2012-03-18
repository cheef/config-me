# ConfigMe

Gem provides convenient tool for storing configurations

## Installation

    gem install config-me

## Usage

    ConfigMe do
      foo do
        bar 'test'
      end
    end

    ConfigMe.foo.bar # => 'test'

