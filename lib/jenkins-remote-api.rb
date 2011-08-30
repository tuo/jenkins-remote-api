require 'mechanize'
require 'libxml'  
Dir[File.dirname(__FILE__) + '/jenkins-remote-api/api/*.rb'].each {|file| require file }
