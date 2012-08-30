module ConfigMe

  class UnrecognizedError < RuntimeError
    def initialize
      super "Really something wrong"
    end
  end

  class ConfigurationNotDefined < StandardError
    def initialize name
      super "Configuration :#{name} not defined"
    end
  end

  class UndefinedSetting < ArgumentError
    def initialize breadcrumbs
      super %(Undefined setting "#{breadcrumbs.join('.')}" for "#{namespace}" configuration)
    end

    private

      def namespace
        ConfigMe::Base.current_namespace || ConfigMe::Defaults.namespace
      end
  end

  class WrongFormat < ArgumentError
    def initialize expected, received
      super %(Expected #{expected} format, but received #{received})
    end
  end
end