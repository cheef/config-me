Feature: dump config data to hash

  Scenario: define config and then dump node to hash
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo do
        bar do
          sample 'test'
        end
      end
    end
    """
    And I dump config node "ConfigMe.foo" to hash
    Then It should be a hash like:
    """
    {
      :bar => {
        :sample => 'test'
      }
    }
    """

  Scenario: define config and then dump all config to hash
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo do
        bar do
          sample 'test'
        end
      end
    end
    """
    And I dump whole config to hash
    Then It should be a hash like:
    """
    {
      :foo => {
        :bar => {
          :sample => 'test'
        }
      }
    }
    """