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

	Scenario: Get all jobs descriptions for specific ci
  	When I run `jenkins jobs_description --ci_address http://ci.jruby.org/view/Ruboto/`
    Then the output should contain:
         """
         [
		 	[0] {
		          :name => "ruboto-core",
		           :url => "http://ci.jruby.org/job/ruboto-core/",
		        :status => "building"
		    },
		    [1] {
		          :name => "ruboto-core_jruby_master",
		           :url => "http://ci.jruby.org/job/ruboto-core_jruby_master/",
		        :status => "failure"
		    },
		    [2] {
		          :name => "ruboto-core_pads",
		           :url => "http://ci.jruby.org/job/ruboto-core_pads/",
		        :status => "building"
		    },
		    [3] {
		          :name => "ruboto-core_pads_jruby_master",
		           :url => "http://ci.jruby.org/job/ruboto-core_pads_jruby_master/",
		        :status => "failure"
		    }
		 ]
         """    	    
	Scenario: Prompt error info when ci address for list all job names has no job infos
		When I run `jenkins list_all_job_names --ci_address http://www.google.com/`
		Then the output should contain "Error in grabbing xml of http://www.google.com/api/xml due to network problem."

	Scenario: Prompt error info when ci address for list all job names return xml that is illegal
		When I run `jenkins list_all_job_names --ci_address http://www.baidu.com/`
		Then the output should contain "Error parsing xml from http://www.baidu.com/api/xml due to format."		
    
	Scenario: Get current build status for job for specific ci
  	When I run `jenkins current_status --job_name ruboto-core --ci_address http://ci.jruby.org/view/Ruboto/`
    Then the output should contain:
         """
		 building
         """    	    

