class ConfigMe::DefinitionsParser

  def self.parse! breadcrumbs = [], &definitions
    new(breadcrumbs, &definitions).instance_variable_get(:@node)
  end

  def initialize breadcrumbs = [], &definitions
    @node = ConfigMe::Node.new(breadcrumbs)
    instance_exec &definitions
  end

  private

    def method_missing method, *args, &definitions
      @node[ method ] = if block_given?
        breadcrumbs = @node.instance_variable_get(:@breadcrumbs)
        ConfigMe::DefinitionsParser.parse! breadcrumbs + [ method ], &definitions
      else
        args.first
      end
    end
end