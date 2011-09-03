require 'rubygems'
require 'mechanize'
module Ci
    module XmlHelper
     private
      def retrieve_xml_from(url)
        xml = nil
        begin  
          Mechanize.new.get(url) do |page|
            xml = page.body
          end
        rescue Mechanize::ResponseCodeError => e
          raise "Error in grabbing xml of #{url}.Pls refer to response code:#{e.response_code}."
        end     
        xml 
      end
      
      def url_with_appended_xml url
         url + "api/xml"
      end
    end
end
