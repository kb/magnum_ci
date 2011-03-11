# Magnum CI
A simple Continuous Integration server built on [Rails](http://rubyonrails.org) and [Resque](http://github.com/defunkt/resque) for [git](http://git-scm.org) controlled projects.

#### Version 0.5.0

## Running in Development

1. Start Redis Server
> $ redis-server /usr/local/etc/redis.conf
(this is where I have it on my MBP, it may be different for you)

2. Start Resque Workers
> $ rake workers:magnum_ci

3. Start Rails Server
> $ rails s

## Readme Driven Development

A <del>strike</del> means its done!

* <del>Add project model</del>
* <del>Add project controller</del>
* <del>Add project views</del>
* <del>Add cucumber</del>
* <del>Add build model</del>
* <del>Add build controller</del>
* <del>Create build show page</del>
* <del>Add Commiter name</del>
* <del>Write some cucumber stories for project</del>
* <del>Add build cleanup functionality (Delete old builds)</del>
* <del>Campfire Integration</del>
* <del>Add ability to delete Projects</del>
* <del>Add Manual Build button for projects</del>
* <del>Add project name to build show page</del>
* <del>Add commit message for each build</del>
* <del>Past build statues on the root page</del>
* <del>Add bundler option to project setup. If yes, export BUNDLE_GEMFILE programattically.</del>
* Add HTTP basic auth to the edit page
* Remove cucumber
* Added rspec tests for view/model/controller/helper
* Fix Magnum rendered HTML in output logs
* Seperate status area with order of queued builds
* Ask Fisher to restyle forms
* Submitted time, and finished time. and/or elapsed time
* Delta timer notifier for when builds go over average build time
* Allow for dynamic build directories
* Build number per project
* Branch integration in build request
* Create writeup on Ubuntu setup
* Figure out a way to dynamically set the URL to the build for campfire

#### I'm sure there's more stuff. Will update.

## Versioning
This project uses Semantic Versioning (http://semver.org/)

## Contributing
All contributions are welcome. Just fork the code, ensure your changes include a test, ensure all the current tests pass and send a pull request.

## Acknowledgments
Created by Kyle Bolton

Additional contributors
* Andrew Vargo
* Jeremy Durham

Copyright (c) 2011 Kyle Bolton, released under the MIT license