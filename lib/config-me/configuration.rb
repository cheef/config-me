class ConfigMe::Configuration

  def initialize &definitions
    @tree = ConfigMe::DefinitionsParser.parse! %w(ConfigMe), &definitions
  end

  def self.clear!
    ConfigMe.instance_variable_set :@current, nil
    ConfigMe.instance_variable_set :@configurations, {}
  end

  private

    def method_missing method, *args, &block
      @tree.send method, *args, &block
    end
end