Feature: raising error on undefined setting

  Scenario Outline: try to get not defined setting and make sure that exception raise
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    And I ask for an "ConfigMe.<key>" setting
    Then It should raise error "ConfigMe::UndefinedSetting" with message:
    """
    Undefined setting "ConfigMe.bar"
    """

  Examples:
    | key         |
    | bar         |
    | bar.foo     |
    | bar.foo.bar |

  Scenario: try to get not defined setting and make sure that breadcrumbs is correct
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
    And I ask for an "ConfigMe.foo.bar.good" setting
    Then It should raise error "ConfigMe::UndefinedSetting" with message:
    """
    Undefined setting "ConfigMe.foo.bar.good"
    """


  Scenario: there are several configuration exists,
    try to get not defined setting and make sure that breadcrumbs is correct
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'test' do
        bar 'good'
      end

      cool 'test'
    end

    ConfigMe :test do
      foo 'test' do
        bar 'good'
      end
    end
    """
    Then setting "ConfigMe.cool" should be equal to "test"
    And I ask for an "ConfigMe(:test).cool.bar" setting
    Then It should raise error "ConfigMe::UndefinedSetting" with message:
    """
    Undefined setting "ConfigMe.cool"
    """

