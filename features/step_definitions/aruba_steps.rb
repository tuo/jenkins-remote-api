#we have defined some customized steps using aruba
Then /^I should see job names "([^\"]*)"$/ do | job_names |
  unescape(all_output).split.join(", ").should == unescape(job_names)
end

#http://www.themodestrubyist.com/2010/04/22/aruba---cucumber-goodness-for-the-command-line/
Then /^I should see "([^\"]*)"$/ do |partial_output|
  unescape(all_output).should =~ unescape(partial_output)
end


#exact match,after remove space and line  just for awesome_print
#http://www.themodestrubyist.com/2010/04/22/aruba---cucumber-goodness-for-the-command-line/
Then /^the output should exactly equal to following without caring about space:$/ do |partial_output|
  all_output.to_s.split.join('').should == partial_output.split.join('')
end


