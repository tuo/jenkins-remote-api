Jenkins Remote API
=============

A gem aims at help you consume [remote-access-api](https://wiki.jenkins-ci.org/display/JENKINS/Remote+access+API) offered by [Jenkins](http://jenkins-ci.org/). 

Why
-------

The Jenkins exposes three kinds of api(xml/json/python) to outside users. And we might ask why we need to consume
those data? 

Well, for a large team(over 6~8 people), how to visualize the ci process status is very important. In opposite to
the way that you manually go to Jenkins website and see the build status(positive), what if we can utilize Kanban methodology.That is to have a screen to show current ci status(passive but with knowledge radiation). Red means failure; Green means good/success;Blue means building in process.Maybe in further, we can buy [The Hudson Bear Lamps](https://wiki.jenkins-ci.org/pages/viewpage.action?pageId=20250625) to show build status.

But the prerequisite is that you need to consume the raw data offered by Jenkins api. So this gem will wrap around 
the raw api from Jenkins, let you make best of it to do thing better.

The following markups are supported.  The dependencies listed are required if
you wish to run the library.


Installation
-----------

    gem install jenkins-remote-api

How to use
------------

###Commands from terminal
 Yes, this gem use [CLI(using Aruba)](https://github.com/cucumber/aruba) to add command line interface so that you can fire it up directly in terminal(cool). 
If you just want to play around with it, you probably don't even need to go to crazy "IRB" console^_^.

*	`jenkins -h` -- It will come up with help message.
* `jenkins list_all_job_names --ci_address http://ci.jruby.org/view/Ruboto/` -- It will list all jobs'name on Jenkins.
* `jenkins jobs_description --ci_address http://ci.jruby.org/view/Ruboto/` -- It will list all jobs description(name,url,status) on Jenkins.
* `jenkins current_status --job_name ruboto-core --ci_address http://ci.jruby.org/view/Ruboto/` -- It will list current building status of job you identified on Jenkins.

####Usage in irb console
	require 'rubygems'
	require 'jenkins-remote-api'
	jenkins = Ci::Jenkins.new("http://ci.jruby.org/view/Ruboto/")
	jenkins.list_all_job_names
	jenkins.jobs_description
	jenkins.current_status_on_job "ruboto-core"
	job = jenkins.job_named "ruboto-core"

Contribute
------------

Want to contribute? Email test: clarkhtse@gmail.com