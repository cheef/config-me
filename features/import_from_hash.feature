Feature: import configuration from hash

  Background:
    Given an configuration hash:
    """
    { :foo => { :bar => 'test' } }
    """

  Scenario: import configuration from hash
    When I read configuration from this hash:
    """
    ConfigMe(:from_hash => @hash)
    """
    Then setting "ConfigMe.foo.bar" should be equal to "test"