module Jenkins
  include LibXML  
  
  def self.set_ci_addr(url)
    @@ci_addr = url.end_with?("/") ? url : url + "/"
  end

  def self.ci_addr
    @@ci_addr
  end
  
  def self.list_all_job_names
    xml = ""
    Mechanize.new.get(ci_addr + "api/xml") do |page|
      xml = page.body
    end
    parser = LibXML::XML::Parser.string(xml)  
    doc = parser.parse
    doc.find('//job').collect{|job| job.find_first('name').content }  
  end
end

