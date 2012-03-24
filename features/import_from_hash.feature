Feature: import configuration from hash

  Background:
    Given an configuration hash:
    """
    @hash = { :foo => { :bar => 'test' }, :sample => '42' }
    """

  Scenario: import configuration from hash
    When I read configuration from this hash:
    """
    ConfigMe(:hash => @hash)
    """
    Then setting "ConfigMe.sample" should be equal to "42"
    And setting "ConfigMe.foo.bar" should be equal to "test"

    When I ask for an "ConfigMe.foo.good" setting
    Then It should raise error "ConfigMe::UndefinedSetting" with message:
    """
    Undefined setting "ConfigMe.foo.good"
    """