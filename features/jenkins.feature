Feature: Jenkins
  In order to consume jenkins api
  As a CLI
  I want to be as objective as possible
	
	Scenario: Get ci address when you set it
		When I run `jenkins ci_address_to http://deadlock.netbeans.org/hudson`
		Then the output should contain "http://deadlock.netbeans.org/hudson/"
		
	Scenario: Get list all job names for specific jenkins ci
		When I run `jenkins list_all_job_names --ci_address http://ci.jruby.org/view/Ruboto/`
		Then I should see job names "ruboto-core, ruboto-core_jruby_master, ruboto-core_pads, ruboto-core_pads_jruby_master"