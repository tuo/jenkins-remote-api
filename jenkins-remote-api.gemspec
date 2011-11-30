# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jenkins-remote-api/version"

Gem::Specification.new do |s|
  s.name        = "jenkins-remote-api"
  s.version     = Jenkins::Remote::Api::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tuo Huang"]
  s.email       = ["clarkhtse@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This gem is to aim at helping people consume the api from Jenkins.}
  s.description = %q{It retrieves the api/xml from Jenkins Ci. Then it will parse it to 
                      get build status. e.g how many jobs are there and what status are those jobs.
                    }

  s.rubyforge_project = "jenkins-remote-api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency 'rspec', '~> 2.6'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rake'
  s.add_dependency 'terminal-table'
  s.add_dependency 'thor'    
  s.add_dependency 'mechanize', '~>2.0.1'
  s.add_dependency 'libxml-ruby','~>2.2.2'
  
end
