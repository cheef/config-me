Feature: raising errors on undefined settings

  Scenario Outline: try to get non defined setting and make sure that exception raise
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    And I ask for an "ConfigMe.<key>" setting
    Then It should raise error "ConfigMe::UndefinedSetting"

  Examples:
    | key         |
    | bar         |
    | bar.foo     |
    | bar.foo.bar |

