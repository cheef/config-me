module ConfigMe

  class UnrecognizedError < Exception
    def initialize
      super "Really something wrong"
    end
  end

  class ConfigurationNotDefined < Exception
    def initialize name
      super "Configuration :#{name} not defined"
    end
  end

  class UndefinedSetting < Exception
    def initialize breadcrumbs
      super %(Undefined setting "#{breadcrumbs.join('.')}")
    end
  end

  class WrongFormat < Exception
    def initialize expected, received
      super %(Expected #{expected} format, but received #{received})
    end
  end
end