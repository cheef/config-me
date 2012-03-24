# Config Me [![Build Status](https://secure.travis-ci.org/cheef/config-me.png "Build Status")](http://travis-ci.org/cheef/config-me) [![Dependency Status](https://gemnasium.com/cheef/config-me.png "Dependency Status")](https://gemnasium.com/cheef/config-me)

Gem provides convenient tool for storing file based configurations.

## Installation

    gem install config-me

In Rails 3, add this to your Gemfile and run the bundle command.

    gem "config-me"

## Defining config

    ConfigMe do
      foo do
        bar 'test'
      end

      sample 666
    end

## Reading config

    ConfigMe.foo.bar # => 'test'
    ConfigMe.sample  # => 666
    ConfigMe.foo     # => an instance of ConfigMe::Node which have some useful methods

    ConfigMe.test    # => will raise exception ConfigMe::UndefinedSetting

## Changing existing config

Let's define config for a start:

    ConfigMe do
      foo do
        bar 'test'
      end
    end

Then we could change value of the existing setting:

    ConfigMe.foo.bar = 'sample'

Or add new setting:

    ConfigMe.foo.sample = 'test'

The only restriction is that we couldn't add setting to not existing node:

    ConfigMe.foo.test.cool = 5 # => will raise exception ConfigMe::UndefinedSetting 'test' for 'ConfigMe.foo'

But we could define it using blocks structure:

    ConfigMe.foo do
      test do
        cool 5
      end
    end

    ConfigMe.foo.test.cool # => 5
    ConfigMe.foo.sample    # => will raise exception ConfigMe::UndefinedSetting, because we redefined whole node

## Namespaces

Every time you define configuration in some namespace, the default is ```:production```,
but you can provide the namespace name you want:

    ConfigMe do
      foo 'bar'
    end

    ConfigMe(:development) do
      foo 'foo'
    end

    ConfigMe.foo               # => 'bar'
    ConfigMe(:production).foo  # => 'bar'
    ConfigMe(:development).foo # => 'foo'

## Importing from hash

If you have a some hash:

    my_hash = { :foo => { :bar => 'test' } }

Your could import it:

    ConfigMe :hash => my_hash
    ConfigMe.foo.bar # => 'test'

## Importing from yaml

    ConfigMe :yaml => '/path/to/my/yaml/configuration'

## Dumping config to hash

    ConfigMe do
      foo do
        bar 'test'
      end
    end

    ConfigMe.to_hash     # => { :foo => { :bar => 'test' } }
    ConfigMe.foo.to_hash # => { :bar => 'test' }

## Auto calling procs

By default if you assign ```proc``` to setting value, then it will be executed while reading. I mean:

    ConfigMe do
      foo proc { 5 + 5 }
      bar proc { |count| count * 2 }
    end

    ConfigMe.foo    # => 10
    ConfigMe.bar(2) # => 4

But you could disable this feature:

    ConfigMe::Defaults.auto_calling_proc = false

## Rails 3 integration

This will be implemented in separate gem ```config-me-rails3``` very soon.






