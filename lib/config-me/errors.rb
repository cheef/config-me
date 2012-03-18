module ConfigMe
  class ConfigurationsNotDefined < Exception
    def initialize
      super "No configurations were defined"
    end
  end

  class UndefinedScope < Exception
    def initialize scope
      super %(Undefined scope "#{scope}")
    end
  end

  class UndefinedSetting < Exception
    def initialize breadcrumbs
      super %(Undefined setting "#{breadcrumbs.join('.')}")
    end
  end
end