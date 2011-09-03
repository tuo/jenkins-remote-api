require 'thor'
require "#{File.dirname(__FILE__)}/ci/jenkins.rb"

module Jenkins
  class CLI < Thor

    desc "ci_address_to", "Initialize a new jenkins instance"
    def ci_address_to url
      jenkins = Ci::Jenkins.new url
      puts jenkins.ci_address
    end 
    
    desc "list_all_job_names", "List all job's name for jenkins ci"
    method_option :ci_address, :aliases => '-ci_addr'
    def list_all_job_names
      jenkins = Ci::Jenkins.new options[:ci_address]
      puts jenkins.list_all_job_names
    end
    
    desc "jobs_description", "List all jobs' description for jenkins ci"
    method_option :ci_address, :aliases => '-ci_addr'
    def jobs_description
      jenkins = Ci::Jenkins.new options[:ci_address]
      ap jenkins.jobs_description
    end
    
    desc "current_status", "Get current status of specific job on jenkins options -ci_addr , -job_name "
    method_option :ci_address, :aliases => '-ci_addr'
    method_option :job_name, :aliases => '-job_name'
    def current_status
      jenkins = Ci::Jenkins.new options[:ci_address]
      ap jenkins.current_status_on_job options[:job_name]
    end
    
       
  end
end