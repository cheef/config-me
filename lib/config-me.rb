require "config-me/version"

module ConfigMe

  class UndefinedSetting < Exception; end

  module Configuration
    def self.parse! &definitions
      @tree = DefinitionsParser.parse! &definitions
    end

    def self.clear!
      @tree = nil
    end

    private

      def self.method_missing method, *args, &block
        if @tree.has_key? method
          @tree[ method ]
        else
          raise ConfigMe::UndefinedSetting.new(%(Undefined setting "#{method}"))
        end
      end
  end

  class Node < Hash
    def method_missing method, *args, &block
      if has_key? method
        self[ method ]
      else
        raise ConfigMe::UndefinedSetting.new(%(Undefined setting "#{@breadcrumbs}.#{method}"))
      end
    end
  end

  class DefinitionsParser

    def self.parse! &definitions
      new(&definitions).instance_variable_get(:@store)
    end

    def initialize &definitions
      @store = Node.new
      instance_exec &definitions
    end

    private

      def method_missing method, *args, &definitions
        @store[ method ] = if block_given?
          DefinitionsParser.parse!(&definitions)
        else
          args.first
        end
      end
  end

  private

    def self.method_missing method, *args, &block
      Configuration.send method, *args, &block
    end
end

def ConfigMe &definitions
  if block_given?
    ConfigMe::Configuration.parse! &definitions
  else
    const_get :ConfigMe
  end
end
