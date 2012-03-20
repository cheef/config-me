Given /^an empty configuration$/ do
  ConfigMe::Configuration.clear!
end

When /^I define configuration below:$/ do |code_string|
  eval code_string
end

Then /^setting "([^"]*)" should be equal to "([^"]*)"$/ do |code_string, value|
  eval(code_string).should == value
end

Then /^setting "([^"]*)" should be of type "([^"]*)"$/ do |code_string, klass|
  eval(code_string).class.name.should == klass
end

When /^I ask for an "([^"]*)" setting$/ do |code_string|
  begin
    @setting = eval(code_string)
  rescue Exception => e
    @error = e
  end
end

Then /^It should raise error "([^"]*)"$/ do |klass|
  @error.class.name.should == klass
end

Then /^It should raise error "([^"]*)" with message:$/ do |klass, message|
  step %(It should raise error "#{klass}")
  @error.message.should == message
end

When /^I rewrite setting with using code below:$/ do |code_string|
  eval code_string
end


