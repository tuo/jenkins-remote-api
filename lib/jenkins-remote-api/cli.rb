require 'thor'
require "#{File.dirname(__FILE__)}/ci/jenkins.rb"

module Ci
  class CLI < Thor
    
    desc "new", "Initialize a new jenkins instance"
    def new url
      @jenkins = Ci::Jenkins.new url
    end

    desc "ci_address", "get the address of ci hudson"
    def ci_address 
      puts  @jenkins.ci_address
    end
    
  end
end