require 'rubygems'
require 'mechanize'
require 'base64'
module Ci
  module XmlHelper

    def initialize
      @options = {}
    end

    private

    # Get XML from url
    #
    # Returns HTTP content from url
    def retrieve_xml_from(url, options = {})
      @options = options
      agent = Mechanize.new
      begin
        xml = retrieve_get(agent, url)
      rescue Mechanize::ResponseCodeError => e
        raise "Error in grabbing xml of #{url}.Pls refer to response code:#{e.response_code}."
      end
      xml
    end

    # Get call to mechanize
    #
    # Returns content from url
    def retrieve_get(agent_obj, url)
      xml = nil
      if @options.empty?
        agent_obj.get(url) { |page| xml = page.body }
      else
        agent_obj.get(url, [], nil, headers) { |page| xml = page.body }
      end
      xml
    end

    # Creating an Authorization header for password protected
    # Jenkins servers
    #
    # Returns hash of Auth Basic or empty hash if no credentials exists
    def headers
      return {} if @options.nil? || @options.empty?
      { 'Authorization' => "Basic #{token}" }
    end

    # Building the token
    #
    # Returns base64 encoded string of username and password
    def token
      t = [@options[:username], @options[:password]].join(':')
      Base64.encode64(t).delete("\r\n")
    end

    # Appending api/xml to url
    #
    # Returns string url with api/xml appended
    def url_with_appended_xml(url)
        url + "api/xml"
    end
  end
end
