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

  def has_key? key
    @values.has_key? key
  end

  def method_missing method, *args, &block
    if has_key? method
      self[ method ]
    else
      raise ConfigMe::UndefinedSetting.new(@breadcrumbs + [method])
    end
  end
end