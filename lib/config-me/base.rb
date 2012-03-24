class ConfigMe::Base

  cattr_accessor :configurations
  cattr_accessor :current_namespace

  attr_accessor :node

  class << self
    def current_configuration
      find_configuration current_namespace || ConfigMe::Defaults.namespace
    end

    def find_configuration namespace
      raise ConfigMe::ConfigurationNotDefined.new(namespace) if !configurations.has_key?(namespace) || namespace.nil?
      configurations[ namespace ]
    end

    def clear!
      self.configurations = {}
      reset_current_namespace!
    end

    def delegate_to_current_configuration method, *args, &block
      current_configuration.node.send(method, *args, &block).tap do
        reset_current_namespace!
      end
    end

    def reset_current_namespace!
      self.current_namespace = nil
    end
  end

end