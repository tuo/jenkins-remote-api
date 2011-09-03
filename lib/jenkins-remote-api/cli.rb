require 'thor'
require 'terminal-table/import'
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
      puts table(['Job Name'], *(jenkins.list_all_job_names.collect{|name| [name]}))
    end
    
    desc "jobs_description", "List all jobs' description for jenkins ci"
    method_option :ci_address, :aliases => '-ci_addr'
    def jobs_description
      jenkins = Ci::Jenkins.new options[:ci_address]
      job_description_table = table do |t|
        t.headings = 'Job Name', 'Job Status', 'Job URL'
        jenkins.jobs_description.each do |job_desc|
          t << job_desc.values
        end
      end
      puts job_description_table  
    end
    
    desc "current_status", "Get current status of specific job on jenkins options -ci_addr , -job_name "
    method_option :ci_address, :aliases => '-ci_addr'
    method_option :job_name, :aliases => '-job_name'
    def current_status
      jenkins = Ci::Jenkins.new options[:ci_address]
      status = jenkins.current_status_on_job options[:job_name]
      puts table(['Job Name', 'Status'], *([[options[:job_name], status]]))
    end
    
       
  end
end