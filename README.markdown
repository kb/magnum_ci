An attempt to write a better CI server.

This will be automated at some point, but for now do the following...

* start the redis server --> redis-server /usr/local/etc/redis.conf
* start build resque --> QUEUE=build rake environment resque:work
* start clone resque --> QUEUE=clone rake environment resque:work
* start the app --> script/server
* send a curl request ---> curl http://localhost:3000/::project name::/build
* start resque front-end ---> resque-web