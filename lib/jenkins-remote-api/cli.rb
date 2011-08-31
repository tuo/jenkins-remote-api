require 'thor'
require File.expand_path(File.join(File.dirname(__FILE__), 'ci','jenkins'))

module Jenkins
  class CLI < Thor
    
    desc "set_ci_addr", "Set the address of ci hudson"
    def set_ci_addr url
      Jenkins.set_ci_addr url
    end

    desc "ci_addr", "get the address of ci hudson"
    def ci_addr 
      puts Jenkins.ci_addr
    end
    
  end
end