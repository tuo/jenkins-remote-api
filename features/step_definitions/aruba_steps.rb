#we have defined some customized steps using aruba
Then /^I should see job names "([^\"]*)"$/ do | job_names |
  unescape(all_output).split.join(", ").should == job_names
end
