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
      begin  
        Mechanize.new.get(ci_address + "api/xml") do |page|
          xml = page.body
        end
      rescue Mechanize::ResponseCodeError => e
        raise "Error in grabbing xml of #{ci_address}/api/xml due to network problem."
      end
      
      parser = LibXML::XML::Parser.string(xml)  
      doc = parser.parse
      doc.find('//job').collect{|job| job.find_first('name').content }  
    end
  end
end