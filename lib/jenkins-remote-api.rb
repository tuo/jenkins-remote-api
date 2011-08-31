require 'mechanize'
require 'libxml'  
Dir[File.dirname(__FILE__) + '/jenkins-remote-api/ci/*.rb'].each {|file| require file }
