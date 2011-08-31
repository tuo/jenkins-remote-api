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
       
  end
end