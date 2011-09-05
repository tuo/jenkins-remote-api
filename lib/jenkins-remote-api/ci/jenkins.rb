require 'libxml'
require "#{File.dirname(__FILE__)}/helper/xml_helper.rb"
require "#{File.dirname(__FILE__)}/job.rb"
module Ci  
  class Jenkins
    include LibXML  
    include XmlHelper
    
    COLOR_STATUS_MAPPING = {
      'blue'              => 'success',
      'red'               => 'failure',
      'blue_anime'        => 'building',
      'red_anime'         => 'building',      
      'disabled'          => 'disabled',    
      'aborted'           => 'aborted',  
      'yellow'            => 'unstable', #rare
    }
    
    attr_accessor :ci_address
    
    def initialize url
      @ci_address = url
    end

    def ci_address
      unless @ci_address.end_with?("/")  
          @ci_address += "/"
      end
      @ci_address      
    end
    
    def list_all_job_names
      jobs_summary.collect{ |job_summary| job_summary[:description][:name]}
    end
    
    def job_named job_name
      get_job_summary_on(job_name)[:job]
    end
    
    def jobs
      jobs_summary.collect{ |job_info| job_info[:job]}
    end    
    
    def jobs_description
      jobs_summary.collect{ |job_info| job_info[:description]}
    end
    
    def current_status_on_job job_name
      get_job_summary_on(job_name)[:description][:status]
    end
    
    private   
      def jobs_summary
        @jobs_summary ||= cached_xml_doc_of_jobs.find('//job').collect {|job_doc|
          name = job_doc.find_first('name').content.strip
          url = job_doc.find_first('url').content.strip
          color = job_doc.find_first('color').content.strip
          { 
            :description => {:name => name, :status => get_status_to(color), :url => url },
            :job => Ci::Job.new(url)
          }
        }
        @jobs_summary
      end
    
      def cached_xml_doc_of_jobs
        return @jobs_highlevel_xml unless @jobs_highlevel_xml.nil?
        xml = retrieve_xml_from(xml_url_on_ci)
        parser = LibXML::XML::Parser.string(xml)        
        begin 
          @jobs_highlevel_xml = parser.parse
        rescue LibXML::XML::Error => e
          raise "Error parsing xml from #{xml_url_on_ci} due to format."
        end
      end

      def xml_url_on_ci
        url_with_appended_xml(ci_address)
      end
      
      def get_status_to color
        raise "This color '#{color}' and its corresponding status hasn't been added to library, pls contact author." unless COLOR_STATUS_MAPPING.has_key?(color)
        COLOR_STATUS_MAPPING[color]
      end
      
      def get_job_summary_on job_name
        targeting_job_summary = jobs_summary.detect{|job_summary| job_summary[:description][:name] == job_name}
        raise "The job with name 'some job' doesn't exist in job list of #{xml_url_on_ci}.Using jenkins.list_all_job_names to see list." if targeting_job_summary.nil?
        targeting_job_summary
      end
  end
end