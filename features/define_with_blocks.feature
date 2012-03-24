Feature: defining configuration using blocks

  Scenario: set 1st level setting
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo 'bar'
    end
    """
    Then setting "ConfigMe.foo" should be equal to "bar"

  Scenario: set 2nd level setting
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo do
        bar 'foo'
      end
    end
    """
    Then setting "ConfigMe.foo.bar" should be equal to "foo"

  Scenario: set 3rd level setting
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo do
        bar do
          sample 'bar'
        end
      end
    end
    """
    Then setting "ConfigMe.foo.bar.sample" should be equal to "bar"

  Scenario Outline: set different types of values and make sure that they are not change
    Given an empty configuration
    When I define configuration below:
    """
    ConfigMe do
      foo <value>
    end
    """
    Then setting "ConfigMe.foo" should be of type "<type>"

  Examples:
    | value          | type      |
    | 'foo'          | String    |
    | 100500         | Fixnum    |
    | 4.3            | Float     |
    | true           | TrueClass |
    | proc { 'foo' } | Proc      |
    | Time.now       | Time      |
    | Date.today     | Date      |

  Scenario: try to get setting before defining any configuration
    Given an empty configuration
    And I ask for an "ConfigMe.foo" setting
    Then It should raise error "ConfigMe::ConfigurationNotDefined" with message:
    """
    Configuration :production not defined
    """

