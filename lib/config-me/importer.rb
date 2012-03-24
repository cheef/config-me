module ConfigMe::Importer

  def self.from_definitions namespace, definitions
    with_configuration(namespace) do |configuration|
      configuration.node = ConfigMe::DefinitionsParser.parse! %w(ConfigMe), &definitions
    end
  end

  def self.from_hash namespace, hash
    raise ConfigMe::WrongFormat.new('hash', hash.class) unless hash.is_a?(Hash)
    with_configuration(namespace) do |configuration|
      configuration.node = convert_hash hash, %w(ConfigMe)
    end
  end

  def self.from_yaml namespace, yaml
    require 'yaml'
    from_hash namespace, YAML::load(File.open(yaml))
  end

  def self.with_configuration namespace
    ConfigMe::Base.new.tap do |configuration|
      yield configuration
      ConfigMe::Base.configurations ||= {}
      ConfigMe::Base.configurations[ namespace ] = configuration
    end
  end

  def self.convert_hash hash, breadcrumbs
    ConfigMe::Node.new(breadcrumbs).tap do |node|
      hash.each do |key, value|
        node[ key.to_sym ] = if value.is_a?(Hash)
          convert_hash value, (breadcrumbs + [ key.to_sym ])
        else
          value
        end
      end
    end
  end

end