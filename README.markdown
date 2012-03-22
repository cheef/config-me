# ConfigMe

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

## Dumping config to hash

    ConfigMe do
      foo do
        bar 'test'
      end
    end

    ConfigMe.to_hash     # => { :foo => { :bar => 'test' } }
    ConfigMe.foo.to_hash # => { :bar => 'test' }






