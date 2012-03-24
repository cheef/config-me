module ConfigMe::Runner
  class << self

    attr_accessor :namespace, :options, :definitions

    def parse namespace_or_options, &definitions
      parse_execution_params! namespace_or_options, &definitions
      case_and_apply_action!
    end

    def case_and_apply_action!
      case
        when reading? then set_current_namespace
        when writing?
          ConfigMe::Importer.from_definitions namespace, definitions
        when importing_from_hash?
          ConfigMe::Importer.from_hash namespace, options[:hash]
        when importing_from_yaml?
          ConfigMe::Importer.from_yaml namespace, options[:yaml]
        else
          raise ConfigMe::UnrecognizedError.new
      end
    end

    def set_current_namespace
      ConfigMe::Base.current_namespace = namespace
    end

    def parse_execution_params! namespace_or_options, &definitions
      self.definitions = definitions

      case
        # ConfigMe.foo
        # ConfigMe(:development).foo
        when namespace_or_options.is_a?(Symbol) || namespace_or_options.is_a?(String)
          self.namespace = namespace_or_options.to_sym
          self.options   = {}

        # ConfigMe(:from_hash => { :foo => :bar })
        # ConfigMe(:namespace => :development)
        when namespace_or_options.is_a?(Hash)
          self.namespace = namespace_or_options.delete(:namespace) || ConfigMe::Defaults.namespace
          self.options   = namespace_or_options
        else
          raise ConfigMe::UnrecognizedError.new
      end
    end

    def reading?
      options.empty? && definitions.nil?
    end

    def writing?
      options.empty? && !definitions.nil?
    end

    def importing_from_hash?
      options.has_key?(:hash)
    end

    def importing_from_yaml?
      options.has_key?(:yaml)
    end
  end
end