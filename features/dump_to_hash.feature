Feature: dump config data to hash

  Scenario: define config and then dump node to hash
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    And I rewrite setting with using code below:
    """
    ConfigMe.foo = 'foo'
    """
    Then setting "ConfigMe.foo" should be equal to "foo"

  Scenario: define config and then dump all config to hash
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    And I rewrite setting with using code below:
    """
    ConfigMe.foo = 'foo'
    """
    Then setting "ConfigMe.foo" should be equal to "foo"