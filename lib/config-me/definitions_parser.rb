class ConfigMe::DefinitionsParser

  def self.parse! breadcrumbs = [], &definitions
    new(breadcrumbs, &definitions).instance_variable_get(:@store)
  end

  def initialize breadcrumbs = [], &definitions
    @store = ConfigMe::Node.new(breadcrumbs)
    instance_exec &definitions
  end

  private

    def method_missing method, *args, &definitions
      @store[ method ] = if block_given?
        breadcrumbs = @store.instance_variable_get(:@breadcrumbs)
        breadcrumbs << method

        ConfigMe::DefinitionsParser.parse! breadcrumbs, &definitions
      else
        args.first
      end
    end
end