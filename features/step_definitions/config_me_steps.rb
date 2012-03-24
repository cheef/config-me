Given /^an empty configuration$/ do
  ConfigMe::Base.clear!
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

When /^I dump config node "([^"]*)" to hash$/ do |code_string|
  @hash = eval(code_string).to_hash
end

Then /^It should be a hash like:$/ do |string_with_hash|
  @hash.should == eval(string_with_hash)
end

When /^I dump whole config to hash$/ do
  @hash = ConfigMe.to_hash
end

Given /^an yaml file with configuration below:$/ do |string|
  require 'tempfile'
  @yaml_file = Tempfile.new('yaml')
  @yaml_file.write string
  @yaml_file.close

  @yaml = @yaml_file.path
end

When /^I read configuration from this yaml file:$/ do |string|
  eval string
end

When /^I read configuration from this yaml string:$/ do |string|
  eval string
end

Given /^an configuration hash:$/ do |string|
  eval string
end

When /^I read configuration from this hash:$/ do |string|
  eval string
end

Then /^setting "([^"]*)" should be a kind of "([^"]*)"$/ do |string, klass|
  eval(string).class.name.should == klass
end

Given /^disabled proc auto calling$/ do
  ConfigMe::Defaults.proc_auto_calling = false
end
