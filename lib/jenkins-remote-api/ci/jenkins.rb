require 'mechanize'
require 'libxml'
module Ci
  class Jenkins
    include LibXML  
    
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
      xml = ""
      xml_url = ci_address + "api/xml"
      begin  
        Mechanize.new.get(xml_url) do |page|
          xml = page.body
        end
      rescue Mechanize::ResponseCodeError => e
        raise "Error in grabbing xml of #{xml_url} due to network problem."
      end
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