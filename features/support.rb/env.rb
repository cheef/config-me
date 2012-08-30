$:.push File.expand_path("../../../lib", __FILE__)

require 'config-me'
require 'rspec/matchers'
require 'yaml'

After do
  ConfigMe::Base.clear!
end