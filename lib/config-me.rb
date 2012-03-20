require 'active_support/dependencies/autoload'

module ConfigMe

  @current = nil
  @configurations = {}

  autoload :VERSION,           'config-me/version'
  autoload :Node,              'config-me/node'
  autoload :Configuration,     'config-me/configuration'
  autoload :DefinitionsParser, 'config-me/definitions_parser'
  autoload :UndefinedSetting,  'config-me/errors'
  autoload :UndefinedScope,    'config-me/errors'
  autoload :ConfigurationsNotDefined, 'config-me/errors'

  private

    def self.method_missing method, *args, &block
      raise ConfigMe::ConfigurationsNotDefined if @current.nil?
      @current.send method, *args, &block
    end
end

def ConfigMe scope = :production, &definitions
  configurations = ConfigMe.instance_variable_get :@configurations

  if block_given?
    configurations[scope] = ConfigMe::Configuration.new(&definitions)
    ConfigMe.instance_variable_set :@configurations, configurations
    ConfigMe.instance_variable_set :@current, configurations[scope]
  else
    raise ConfigMe::UndefinedScope.new(scope) unless configurations.has_key?(scope)
    ConfigMe.instance_variable_set :@current, configurations[scope]
    ConfigMe
  end
end
