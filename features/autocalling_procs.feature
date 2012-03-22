Feature: if setting value is proc then it should be called automatically when it is asks

  Scenario: define configuration
    assign proc to one of the setting
    then ask this setting and make sure that proc is called automatically
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo proc { 'bar' }
    end
    """
    Then setting "ConfigMe.foo" should be equal to "bar"

  Scenario: define configuration
    assign proc to one of the setting
    then ask this setting with params and make sure that proc is called with params automatically
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo proc { |first, second| (first - second).times.map{ 'bar' }.join('-') }
    end
    """
    Then setting "ConfigMe.foo(5, 3)" should be equal to "bar-bar"

  Scenario: define configuration
  disable procs autocalling
  assign proc to one of the setting
  then ask this setting and make sure that proc is not called automatically
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo proc { 'bar' }
    end
    """
    Then setting "ConfigMe.foo" should be equal a kind of "Proc"
