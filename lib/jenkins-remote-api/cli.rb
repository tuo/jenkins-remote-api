require 'thor'
require "#{File.dirname(__FILE__)}/ci/jenkins.rb"

module Jenkins
  class CLI < Thor

    desc "ci_address_to", "Initialize a new jenkins instance"
    def ci_address_to url
      jenkins = Ci::Jenkins.new url
      puts jenkins.ci_address
    end 
       
  end
end