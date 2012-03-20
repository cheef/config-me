Feature: possibility to rewrite existing setting

  Scenario: define config and then rewrite existing setting
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

  Scenario: define config and try add new setting to existing node
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    And I rewrite setting with using code below:
    """
    ConfigMe.bar = 'foo'
    """
    Then setting "ConfigMe.bar" should be equal to "foo"

  Scenario: define config and try rewrite whole node
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    And I rewrite setting with using code below:
    """
    ConfigMe.foo do
      bar 'foo'
    end
    """
    Then setting "ConfigMe.foo.bar" should be equal to "foo"