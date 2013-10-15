require 'yaml'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/class/attribute_accessors'

module ConfigMe
  extend ActiveSupport::Autoload

  autoload :Base,              'config-me/base'
  autoload :Defaults,          'config-me/defaults'
  autoload :DefinitionsParser, 'config-me/definitions_parser'
  autoload :Importer,          'config-me/importer'
  autoload :Node,              'config-me/node'
  autoload :Runner,            'config-me/runner'
  autoload :UnrecognizedError,       'config-me/errors'
  autoload :UndefinedSetting,        'config-me/errors'
  autoload :ConfigurationNotDefined, 'config-me/errors'
  autoload :WrongFormat,             'config-me/errors'

  private

    def self.method_missing method, *args, &block
      ConfigMe::Base.delegate_to_current_configuration method, *args, &block
    end
end

def ConfigMe namespace_or_options = ConfigMe::Defaults.namespace, &definitions
  ConfigMe.tap { ConfigMe::Runner.parse namespace_or_options, &definitions }
end
