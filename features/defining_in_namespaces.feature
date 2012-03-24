Feature: defining configuration in different namespaces

  Scenario: define configuration in namespace and check that it accessible through namespace name
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe :development do
      foo 'bar'
    end
    """
    Then setting "ConfigMe(:development).foo" should be equal to "bar"

  Scenario: define configuration without namespace and check that it accessible through default namespace
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    Then setting "ConfigMe(:production).foo" should be equal to "bar"

  Scenario: try to get setting from not existing configuration and make sure that proper error raise
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    And I ask for an "ConfigMe(:test).foo.bar.good" setting
    Then It should raise error "ConfigMe::ConfigurationNotDefined" with message:
    """
    Configuration :test not defined
    """

  Scenario: define configuration in several scopes
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'test'
    end
    """
    When I define configuration below:
    """
    ConfigMe :bar do
      foo 'bar'
    end
    """
    When I define configuration below:
    """
    ConfigMe :foo do
      foo 'foo'
    end
    """
    Then setting "ConfigMe.foo" should be equal to "test"
    Then setting "ConfigMe(:foo).foo" should be equal to "foo"
    And setting "ConfigMe(:bar).foo" should be equal to "bar"
    And setting "ConfigMe.foo" should be equal to "test"
