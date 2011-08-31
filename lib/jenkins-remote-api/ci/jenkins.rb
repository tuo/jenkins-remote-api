module Ci
  class Jenkins
    include LibXML  
    
    attr_accessor :ci_address
    
    def initialize url
      p "initialize #{url}================"
      @ci_address = url
    end

    def ci_address
      p "get ci_address #{@ci_address}================"
      @ci_address
    end
  
    def list_all_job_names
      xml = ""
      Mechanize.new.get(ci_address + "api/xml") do |page|
        xml = page.body
      end
      parser = LibXML::XML::Parser.string(xml)  
      doc = parser.parse
      doc.find('//job').collect{|job| job.find_first('name').content }  
    end
  end
end