Feature: Jenkins
	In order to set ci address for jenkins
	As a CLI
	I want to be as objective as possible
	
	Scenario: Get ci address when you set it
		When I run `ci new http://www.jenkins.com:8080/`
		When I run `ci ci_address`
		Then the output should contain "http://www.jenkins.com:8080/"