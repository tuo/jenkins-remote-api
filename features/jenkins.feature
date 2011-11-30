Feature: Jenkins
  In order to consume jenkins api
  As a CLI
  I want to be as objective as possible

	Scenario: Get ci address when you set it
		When I run `jenkins ci_address_to http://deadlock.netbeans.org/hudson`
		Then the output should contain "http://deadlock.netbeans.org/hudson/"

	Scenario: Get list all job names for specific jenkins ci
		When I run `jenkins list_all_job_names --ci_address http://ci.jruby.org/view/JRuby%20Core/`
	    Then the output should exactly equal to following without caring about space:
	         """
			+-------------------------+
			| Job Name                |
			+-------------------------+
			| jruby-base              |
			| jruby-dist              |
			| jruby-git               |
			| jruby-test-all          |
			| jruby-test-jar-complete |
			| jruby-windows           |
			| spec-ci                 |
			+-------------------------+
	         """

	Scenario: Get all jobs descriptions for specific ci
	  When I run `jenkins jobs_description --ci_address http://ci.jruby.org/view/JRuby%20Core/`
	  Then the output should exactly equal to following without caring about space:
	         """
			+-------------------------+------------+--------------------------------------------------+
			| Job Name                | Job Status | Job URL                                          |
			+-------------------------+------------+--------------------------------------------------+
			| jruby-base              | failure    | http://ci.jruby.org/job/jruby-base/              |
			| jruby-dist              | failure    | http://ci.jruby.org/job/jruby-dist/              |
			| jruby-git               | success    | http://ci.jruby.org/job/jruby-git/               |
			| jruby-test-all          | failure    | http://ci.jruby.org/job/jruby-test-all/          |
			| jruby-test-jar-complete | success    | http://ci.jruby.org/job/jruby-test-jar-complete/ |
			| jruby-windows           | failure    | http://ci.jruby.org/job/jruby-windows/           |
			| spec-ci                 | failure    | http://ci.jruby.org/job/spec-ci/                 |
			+-------------------------+------------+--------------------------------------------------+
	         """

	Scenario: Prompt error info when ci address for list all job names has no job infos
		When I run `jenkins list_all_job_names --ci_address http://www.google.com/`
		Then the output should contain "Error in grabbing xml of http://www.google.com/api/xml.Pls refer to response code:404."

	Scenario: Prompt error info when ci address for list all job names return xml that is illegal
		When I run `jenkins list_all_job_names --ci_address http://www.baidu.com/`
		Then the output should contain "Error parsing xml from http://www.baidu.com/api/xml due to format."

	Scenario: Get current build status for job for specific ci
	  When I run `jenkins current_status --job_name ruboto-core --ci_address http://ci.jruby.org/`
	  Then the output should exactly equal to following without caring about space:
         """
				+-------------+---------+
				| Job Name    | Status  |
				+-------------+---------+
				| ruboto-core | failure |
				+-------------+---------+
         """


