Feature: possibility to rewrite existing setting

  Scenario: define config and then rewrite existing setting
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
    Then It should be a hash
    And hash should have "bar" key

  Scenario: define config and try add new setting to existing node
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
    Then It should be a hash
    And hash should have "foo" key