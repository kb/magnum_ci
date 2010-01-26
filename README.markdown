An attempt to write a better CI server.

This will be automated at some point, but for now do the following...

So far the build is queued up and the project repo is cloned to its own folder under /builds/::name of a project in magnum ci::/::last commit bit::

* start the redis server --> redis-server /usr/local/etc/redis.conf
* start resque --> QUEUE=* rake environment resque:work (the splat can be replaced with any string value)
* start the app --> script/server
* send a curl request ---> curl http://localhost:3000/::name of a project in magnum ci::/builds/new
* start resque front-end ---> resque-web