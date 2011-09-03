require 'libxml'
require "#{File.dirname(__FILE__)}/helper/xml_helper.rb"
module Ci  
  class Jenkins
    include LibXML  
    include XmlHelper
    
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
      xml_url = ci_address + "api/xml"
      xml = retrieve_xml_from(xml_url)
      parser = LibXML::XML::Parser.string(xml)        
      begin 
        doc = parser.parse
      rescue LibXML::XML::Error => e
        raise "Error parsing xml from #{xml_url} due to format."
      end
      
      doc.find('//job').collect{|job| job.find_first('name').content }  
    end
  end
end