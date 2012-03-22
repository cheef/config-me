class ConfigMe::Node

  def initialize breadcrumbs = []
    @values, @breadcrumbs = {}, breadcrumbs
  end

  def []=(key, value)
    @values[ key ] = value
  end

  def [] key
    @values[ key ]
  end

  def to_hash
    @values.inject({}) do |new_hash, pair|
      key, value = pair

      new_hash[ key ] = value.is_a?(ConfigMe::Node) ? value.to_hash : value
      new_hash
    end
  end

  def method_missing method, *args, &definitions
    case
      when block_given?     then self[ method ] = ConfigMe::DefinitionsParser.parse!(@breadcrumbs, &definitions)
      when setter?(method)  then self[ setter_method(method) ] = args.first
      when has_key?(method) then self[ method ]
      else raise ConfigMe::UndefinedSetting.new(@breadcrumbs + [method])
    end
  end

  private

    def setter? key
      key.to_s =~ /^[a-zA-Z0-9_]+=$/
    end

    def setter_method key
      key.to_s.gsub(/\=/, '').to_sym
    end

    def has_key? key
      @values.has_key? key
    end
end