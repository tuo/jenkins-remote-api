Feature: Jenkins
  In order to consume jenkins api
  As a CLI
  I want to be as objective as possible
	
	Scenario: Get ci address when you set it
		When I run `ci ci_address_to http://deadlock.netbeans.org/hudson`
		Then the output should contain "http://deadlock.netbeans.org/hudson/"