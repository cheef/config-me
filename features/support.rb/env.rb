require 'coveralls'
Coveralls.wear!

require 'config-me'
require 'rspec/matchers'

After do
  ConfigMe::Base.clear!
end