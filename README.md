Jenkins Remote API
=============

A gem to help you access the [Jenkins](http://jenkins-ci.org/)'s [remote-access-api](https://wiki.jenkins-ci.org/display/JENKINS/Remote+access+API).

Why
-------

Jenkins exposes three kinds of api (xml, json, and python).

For a large team (over 6~8 people) visualizing the ci process status is very important. Instead of manually going to Jenkins website to see the build status (positive), what if we utilized Kanban methodology? We could have a screen to show current CI status (passive but with knowledge radiation).

Red means failure. Green means good/success. Blue means building in process.

Maybe even further; we can buy [The Hudson Bear Lamps](https://wiki.jenkins-ci.org/pages/viewpage.action?pageId=20250625) to show build status?

To do something like that, you need to consume the raw data offered by Jenkins api.

This gem makes it easy to access the raw api from Jenkins.

Installation
-----------

    gem install jenkins-remote-api

How to use
------------

###Commands from terminal

This gem has a CLI (using [Aruba])(https://github.com/cucumber/aruba) so that you can fire it up directly in terminal. Cool!

If you just want to play around with it you don't even need to go to the crazy "IRB" console `^_^`.

*	`jenkins -h` -- Your handy online guide.
* `jenkins list_all_job_names --ci_address http://ci.jruby.org/view/Ruboto/` -- List all the job names.
* `jenkins jobs_description --ci_address http://ci.jruby.org/view/Ruboto/` -- List all the job descriptions (name,url,status).
* `jenkins current_status --job_name ruboto-core --ci_address http://ci.jruby.org/view/Ruboto/` -- List current building status of the job you specify (`ruboto-core` in the example).

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

Want to contribute? Email to: clarkhtse@gmail.com